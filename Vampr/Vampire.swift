// Copyright (c) 2017 Lighthouse Labs. All rights reserved.
// 
// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
// distribute, sublicense, create a derivative work, and/or sell copies of the
// Software in any work that is designed, intended, or marketed for pedagogical or
// instructional purposes related to programming, coding, application development,
// or information technology.  Permission for such use, copying, modification,
// merger, publication, distribution, sublicensing, creation of derivative works,
// or sale is expressly withheld.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

class Vampire {
  
  var name: String
  var yearConverted: Int
  var offspring: [Vampire] = []
  var creator: Vampire?
  
  init(name: String, yearConverted: Int) {
    self.name = name
    self.yearConverted = yearConverted
  }
  
  // MARK: Simple tree methods
  
  /// Adds the vampire as an offspring of this vampire
  func add(offspring: Vampire) {
    self.offspring.append(offspring)
    offspring.creator = self
  }
  
  /// The total number of vampires created by that vampire
  var numberOfOffspring: Int {
    return self.offspring.count
  }
  
  /// Returns the number of vampires away from the original vampire this vampire is
  var numberOfVampiresFromOriginal: Int {
    var numberOfVampiresAway = 0
    var currentVampire = self
    
    while true {
      guard let creator = currentVampire.creator else {
        break
      }
      currentVampire = creator
      numberOfVampiresAway += 1
    }
    return numberOfVampiresAway
  }
  
  /// Returns true if this vampire is more senior than the other vampire. (Who is closer to the original vampire)
  func isMoreSenior(than vampire: Vampire) -> Bool {

    func numberOfVampiresFromOriginal2(vampire: Vampire) -> Int {
      
      var numberOfVampiresAway = 0
      var currentVampire = vampire
      
      while true {
        guard let creator = currentVampire.creator else {
          break
        }
        currentVampire = creator
        numberOfVampiresAway += 1
      }
      return numberOfVampiresAway
    }
    let selfVamp:Int = self.numberOfVampiresFromOriginal
    let vampVamp:Int = vampire.numberOfVampiresFromOriginal
    if selfVamp < vampVamp{
      return true
    }else{
      return false
    }
  }

  
  // MARK: Tree traversal methods
  
  /// Returns the vampire object with that name, or null if no vampire exists with that name
  func vampire(withName name: String) -> Vampire? {
    
    if self.name == name{
      return self
    }else{
      for child in offspring {
        let thisVampr = child.vampire(withName: name)
        if thisVampr != nil{
          return thisVampr
        }
      }
    }
    return nil
  }
  
  /// Returns the total number of vampires that exist
  var totalDescendent: Int {
    var  total = self.offspring.count
      if self.offspring.isEmpty{
      }else{
        for child in offspring{
          total += child.totalDescendent
          if child.offspring.isEmpty{
        }
      }
    }
    return total
  }
  
  /// Returns an array of all the vampires that were converted after 1980
  var allMillennialVampires: [Vampire] {
    
    var millennials = [Vampire]()
    if (self.yearConverted > 1980) {
      millennials.append(self)
    }
    for child in self.offspring {
      millennials += child.allMillennialVampires
    }
    return millennials
  }
  
  // MARK: Stretch 
  
  /**
    Returns the closest common ancestor of two vampires.
    The closest common anscestor should be the more senior vampire if a direct ancestor is used.
 
    - Example:
      * when comparing Ansel and Sarah, Ansel is the closest common anscestor.
      * when comparing Ansel and Andrew, Ansel is the closest common anscestor.
   */
  func closestCommonAncestor(vampire: Vampire) -> Vampire {
    return vampire
  }
}
