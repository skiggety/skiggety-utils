#!/usr/bin/env bash

# This script tests 'todo' from the outside, written in bash because what the heck.

THIS_DIR="$(cd "$(dirname $BASH_SOURCE)";pwd)"
. $SKIGGETY_UTILS_DIR/lib/skiggety-utils.bash || exit 1
todo_examples_dir="$THIS_DIR/examples/todo"

function main {
    test_todo_shows_nothing_from_empty_dir || exit_with_error "test failed"
    test_todo_shows_nothing_from_empty_file || exit_with_error "test failed"
    test_todo_sorts_two_equivalent_lines_by_line_number_and_exits_correctly || exit_with_error "test failed"
    test_todo_finds_and_sorts_concise_format_correctly || exit_with_error "test failed"
    test_todo_handles_a_complex_example || exit_with_error "test failed"
    echo "tests PASSED"
}

function test_todo_shows_nothing_from_empty_dir {
    pushd "$todo_examples_dir/empty_dir" > /dev/null
    result="$(todo -k TXDX)"
    exit_value="$?"
    assert_equal "" "$result"
    assert_equal "0" "$exit_value"
    popd > /dev/null
}

function test_todo_shows_nothing_from_empty_file {
    pushd "$todo_examples_dir/empty_file_dir" > /dev/null
    result="$(todo -k TXDX)"
    exit_value="$?"
    assert_equal "" "$result"
    assert_equal "0" "$exit_value"
    popd > /dev/null
}

function test_todo_sorts_two_equivalent_lines_by_line_number_and_exits_correctly {
    pushd "$todo_examples_dir/simple" > /dev/null
    result="$(todo -k TXDX)"
    exit_value="$?"
    expected="./example.txt:1:TXDX: this is a todo
./example.txt:2:  TXDX: this is another todo that's indented"
    assert_equal "$expected" "$result"
    assert_equal "0" "$exit_value"
    popd > /dev/null
}

function test_todo_finds_and_sorts_concise_format_correctly {
    pushd "$todo_examples_dir/mixed_conciseness" > /dev/null
    result="$(todo -k TXDX)"
    exit_value="$?"
    expected="./long_example.txt:1:TXDX^2: this is a todo with the keyword listed twice
./concise_example.txt:1:TXDX^13: this is a todo with concise syntax to specify 13 votes"
    assert_equal "$expected" "$result"
    assert_equal "0" "$exit_value"
    popd > /dev/null
}

function test_todo_handles_a_complex_example {
    pushd "$todo_examples_dir" > /dev/null
    result="$(todo -k TXDX --exclude-dir exclude_me --exclude nasty/excluded.txt)"
    exit_value="$?"
    expected="./simple/example.txt:1:TXDX: this is a todo
./simple/example.txt:2:  TXDX: this is another todo that's indented
./filename_a.txt:1:TXDX^2: sort by filename and line number    /
./filename_a.txt:2:TXDX^2: sort by filename and line number   /
./filename_b.txt:1:TXDX^2: sort by filename and line number  /
./filename_b.txt:2:TXDX^2: sort by filename and line number /
./mixed_conciseness/long_example.txt:1:TXDX^2: this is a todo with the keyword listed twice
./nasty/filename_with_a_fake_line:3:number.txt:2:TXDX^2:6:and_a_fake_line_number_in_the_text
./nasty/filename_with_a_fake_line:4:number.txt:1:TXDX^2:5:and_a_fake_line_number_in_the_text
./nasty/filename_with_a_fake_line:4:number.txt:2:TXDX^2:4:and_a_fake_line_number_in_the_text
./votes.txt:2:TXDX^2: this todo is spelled out like todo todo
./votes.txt:3:TXDX^2: one item and TXDX^3 another on the same line. votecount should be 3.
./votes.txt:4:TXDX^2: one spelled out item and TXDX^3 another concisely-voted item on the same line
./votes.txt:5:TXDX^4: votes are already partially collapsed
./votes.txt:1:TXDX^6: six votes, this should sort
./mixed_conciseness/concise_example.txt:1:TXDX^13: this is a todo with concise syntax to specify 13 votes"
    assert_equal "$expected" "$result"
    assert_equal "0" "$exit_value"
    popd > /dev/null
}

main "$@"
