#!/bin/env python
# -*- coding: utf-8 -*-
import codecs
import unicodedata
import sys

# @Desc    : preprocess for raw data
# @license : Copyright(C), Sogou Inc.


"""--------------------------------"""
def q2b(ustring):
    """全角转半角"""
    rstring = u""
    for uchar in ustring:
        inside_code=ord(uchar)
        if inside_code == 12288:
            inside_code = 32
        elif (inside_code >= 65281 and inside_code <= 65374):
            inside_code -= 65248

        rstring += chr(inside_code)
        #rstring += unichr(inside_code)
    return rstring

if __name__=="__main__":
    if len(sys.argv[:]) != 1:
        print >>sys.stderr,"%s < input > output\n"%(__file__)
        sys.exit(1)

    for line in sys.stdin:
        sys.stdout.write(str(q2b(line.encode("utf-8").decode("utf-8")))) #.encode("utf-8"))
