#!/usr/bin/env python

import unittest
import os

class TestTodo(unittest.TestCase):

    def test_empty_dir(self):
        os.system('mkdir -p /tmp/empty;cd /tmp/empty; todo > /tmp/should.be.empty.txt')
        result = open('/tmp/should.be.empty.txt', 'r').read()
        self.assertEqual(result,"","should be empty")
