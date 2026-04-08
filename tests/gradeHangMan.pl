#!/usr/bin/env perl
use strict;
use warnings;
use Expect;
use JSON::PP;
use File::Path qw(make_path);
use IO::File;
use Cwd qw(getcwd);

###############################################################################
# Data structures for event logging
###############################################################################

my @events;        # Each event: { name => "...", printed => "...", points => N }
my $eventIndex = 1;  # event_01, event_02, ...

# Capture raw log
my $graderLog = '';

sub logEvent {
    my ($printed, $points) = @_;
    my $name = sprintf("event_%02d", $eventIndex++);
    push @events, {
        name    => $name,
        printed => $printed,
        points  => $points,
        max_points => $points,
        status  => ($points > 0 ? "PASS" : "FAIL"),
    };

    # append to master log
    $graderLog .= "$printed\n";

    return;
}

sub recordRaw {
    my ($txt) = @_;
    $graderLog .= $txt;
}

###############################################################################
# Setup
###############################################################################

my $originalDir = getcwd();
recordRaw("Original directory: $originalDir\n");

my $grade = 0;
my $checks = 0;

###############################################################################
# Helper: run an Expect sequence and wrap what your original grader prints
###############################################################################

sub runExpectBlock {
    my ($command, $callbacks) = @_;

    my $exp = Expect->spawn($command)
        or die "Cannot spawn $command: $!\n";

    $exp->log_stdout(0);

    while (my ($timeout, $expectList) = splice(@$callbacks, 0, 2)) {
        $exp->expect($timeout, @$expectList);
    }

    $exp->hard_close();
}

###############################################################################
# === ORIGINAL TEST LOGIC, now wrapped with logEvent() calls ===
###############################################################################

############### 1. Improper CLI test ################

{
    my $command = "./hangMan.ghc ";
    my $exp = Expect->spawn($command) or die "Cannot spawn $command: $!\n";
    $exp->log_stdout(0);

    $exp->expect(
        1,
        [
            '^Usage' => sub {
                logEvent("Improper CLI performed correctly: +1", 1);
                $grade++;
            }
        ],
        [
            timeout => sub {
                logEvent("Improper CLI flow: failed", 0);
            }
        ],
        [
            eof => sub {
                logEvent("Improper CLI flow: failed", 0);
            }
        ]
    );

    $exp->hard_close();
}

############### 2. Valid input test ################

{
    my $command = "./hangMan.ghc -d";
    my $exp = Expect->spawn($command) or die "Cannot spawn $command: $!\n";
    $exp->log_stdout(0);

    # initial prompt
    $exp->expect(
        5,
        [
            '^Pick a letter: ' => sub {
                logEvent("Initial prompt correct: +1", 1);
                $grade++;
            }
        ],
        [
            timeout => sub {
                logEvent("Initial prompt failed", 0);
            }
        ],
        [
            eof => sub {
                logEvent("Initial prompt failed (EOF)", 0);
            }
        ]
    );

    # correct-character sequence
    foreach my $character (qw/i n t e g r a l/) {
        $exp->send("$character\n");
        $exp->expect(
            2,
            [
                '✅' => sub {
                    logEvent("Correct character: +1", 1);
                    $checks++;
                }
            ],
            [
                timeout => sub {
                    logEvent("Correct character (timeout)", 0);
                }
            ],
            [
                eof => sub {
                    logEvent("Correct character (EOF)", 0);
                }
            ]
        );
    }

    # win condition
    $exp->expect(
        5,
        [
            '🎉' => sub {
                logEvent("Correct win: +1", 1);
                $grade++;
            }
        ],
        [
            timeout => sub {
                logEvent("Correct win failed", 0);
            }
        ],
        [
            eof => sub {
                logEvent("Correct win failed (EOF)", 0);
            }
        ]
    );

    # final extra check for matching count
    if ($checks == 7) {
        logEvent("Correct character aggregate: +1", 1);
        $grade++;
    }

    $exp->hard_close();
}

############### 3. Invalid input test ################

{
    my $command = "./hangMan.ghc -d";
    my $exp = Expect->spawn($command) or die "Cannot spawn $command: $!\n";
    $exp->log_stdout(0);

    my @badInputs = ("z", "z", "abc", 9,  " ", "");

    foreach my $character (@badInputs) {
        $exp->send($character);
        $exp->send("\n");

        $exp->expect(
            2,
            [
                '❌1:' => sub {
                    logEvent("❌1: Correct bad-input response: +1", 1);
                    $grade++;
                }
            ],
            [
                '❌2:' => sub {
                    logEvent("❌2: Correct bad-input response: +1", 1);
                    $grade++;
                }
            ],
            [
                '❌3:' => sub {
                    logEvent("❌3: Correct bad-input response: +1", 1);
                    $grade++;
                }
            ],
            [
                '❌4:' => sub {
                    logEvent("❌4: Correct bad-input response: +1", 1);
                    $grade++;
                }
            ],
            [
                '❌5:' => sub {
                    logEvent("❌5: Correct bad-input response: +1", 1);
                    $grade++;
                }
            ],
            [
                '❌6:' => sub {
                    logEvent("❌6: Correct bad-input response: +1", 1);
                    $grade++;
                }
            ],
            [
                timeout => sub {
                    logEvent("Incorrect character (timeout)", 0);
                }
            ],
            [
                eof => sub {
                    logEvent("Incorrect character (EOF)", 0);
                }
            ]
        );
    }

    # lose condition
    $exp->expect(
    5,
    [
        qr/💀/ => sub {
            logEvent("Correct lose: +1", 1);
            $grade++;
        }
    ],
    [
        eof => sub {
            # Try to salvage buffered data
            my $before = $exp->before();
            if ($before =~ /💀/) {
                logEvent("Correct lose (matched before EOF): +1", 1);
                $grade++;
            } else {
                logEvent("Correct lose failed", 0);
            }
        }
    ],
    [
        timeout => sub {
            logEvent("Correct lose failed", 0);
        }
    ]
);

    $exp->hard_close();
}

###############################################################################
# === All tests complete: produce output files ===
###############################################################################

# Create directories
make_path("feedback");
make_path("autograde_results");  # optional, required by template compatibility

###############################################################################
# Write grade.txt
###############################################################################
{
    my $fh = IO::File->new("grade.txt", "w")
        or die "Cannot write grade.txt: $!";
    print $fh $grade, "\n";
    $fh->close;
}

###############################################################################
# Write grader.log
###############################################################################
{
    my $fh = IO::File->new("grader.log", "w")
        or die "Cannot write grader.log: $!";
    print $fh $graderLog;
    $fh->close;
}

###############################################################################
# Write individual event logs: feedback/test_event_XX.out
###############################################################################
foreach my $ev (@events) {
    my $fname = "feedback/test_$ev->{name}.out";
    my $fh = IO::File->new($fname, "w")
        or die "Cannot write $fname: $!";
    print $fh $ev->{printed}, "\n";
    $fh->close;
}

###############################################################################
# Write feedback/summary.txt
###############################################################################
{
    my $fh = IO::File->new("feedback/summary.txt", "w")
        or die "Cannot write summary.txt: $!";

    print $fh "Total score: $grade / 10\n\n";
    print $fh "Event log (in order):\n";

    foreach my $ev (@events) {
        print $fh "$ev->{name}: $ev->{printed}\n";
    }

    $fh->close;
}

###############################################################################
# Write feedback/tests.json
###############################################################################
{
    my %json = ( tests => \@events );
    my $encoded = JSON::PP->new->pretty->encode(\%json);

    my $fh = IO::File->new("feedback/tests.json", "w")
        or die "Cannot write tests.json: $!";
    print $fh $encoded;
    $fh->close;
}

###############################################################################
# Write results.json (canonical grading output)
###############################################################################
{
    my $testsPassed = scalar grep { $_->{points} > 0 } @events;
    my $testsFailed = scalar @events - $testsPassed;

    my %results = (
        score        => $grade,
        max_score    => 10,
        tests_passed => $testsPassed,
        tests_failed => $testsFailed,
    );

    my $encoded = JSON::PP->new->pretty->encode(\%results);

    my $fh = IO::File->new("results.json", "w")
        or die "Cannot write results.json: $!";
    print $fh $encoded;
    $fh->close;
}

###############################################################################
# Done
###############################################################################

exit 0;
__END__

        not in word	        - ❌1:
        null                - ❌2:  
        space               - ❌3:
        multiple chars      - ❌4:
        non-alphabetic      - ❌5:
        previously guessed  - ❌6:
        word file not found - ❌7:
        win	                - 🎉
        lose                - 💀

