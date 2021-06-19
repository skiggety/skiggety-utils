#!/usr/bin/env bash

# This script tests 'todo' from the outside, written in bash because what the heck.

THIS_DIR="$(cd "$(dirname $BASH_SOURCE)";pwd)"
. $THIS_DIR/../lib/skiggety-utils.bash || exit 1

# TODO TODO: turn debug output off

function main {
    test_todo_shows_nothing_from_empty_dir || exit_with_error "test failed"
    test_todo_sorts_two_equivalent_lines_by_line_number_and_exits_correctly || exit_with_error "test failed"
    test_todo_handles_a_complex_example || exit_with_error "test failed"

    # TODO TODO TODO TODO TODO: more top level tests
    # TODO TODO TODO: change todo tests to use an alternate keyword, like "TXDX" or "EXAMPLE_KEYWORD", so it doesn't interfere with the real todo report

    # If all the tests pass, use the new program as the real TODO:
    # TODO TODO TODO: cp "$(which todo-new)" "$(which todo)"
}

function test_todo_shows_nothing_from_empty_dir {
    pushd "$THIS_DIR/examples/todo/empty_dir"
    result="$(todo-new)"
    exit_value="$?"
    assert_equal "0" "$exit_value"
    assert_equal "" "$result"
    popd
}

function test_todo_sorts_two_equivalent_lines_by_line_number_and_exits_correctly {
    pushd "$THIS_DIR/examples/todo/simple"
    result="$(todo-new)"
    exit_value="$?"
    assert_equal "0" "$exit_value"
    expected="./example.txt:1:TODO: this is a todo
./example.txt:2:TODO: this is another todo"
    assert_equal "$expected" "$result"
    popd
}

function test_todo_handles_a_complex_example {
    pushd "$THIS_DIR/examples/todo"
    result="$(todo-new)"
    exit_value="$?"
    assert_equal "0" "$exit_value"
    expected="./simple/example.txt:1:TODO: this is a todo
./simple/example.txt:2:TODO: this is another todo"
# TODO: add:./votes.txt:3:TODO^2: this todo is spelled out like todo todo
    assert_equal "$expected" "$result"
    popd
}

main "$@"
