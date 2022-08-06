# SPDX-License-Identifier: MIT
# @version ^0.3.4

storedNumer: uint256

@external
def storeNumber(newNumber: uint256):
    self.storedNumer = newNumber

@external 
@view
def readNumber() -> uint256:
    return self.storedNumer