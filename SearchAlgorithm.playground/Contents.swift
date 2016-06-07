//: Playground - noun: a place where people can play

import UIKit

//------------------------------------
// Quicksort
//------------------------------------

func partition(inout dataList: [Int], low: Int, high: Int) -> Int {
    var pivotPos = low
    let pivot = dataList[low]
    
    for var i = low + 1; i <= high; i++ {
        if dataList[i] < pivot && ++pivotPos != i {
            (dataList[pivotPos], dataList[i]) = (dataList[i], dataList[pivotPos])
        }
    }
    (dataList[low], dataList[pivotPos]) = (dataList[pivotPos], dataList[low])
    return pivotPos
}

func quickSort(inout dataList: [Int], left: Int, right: Int) {
    if left < right {
        let pivotPos = partition(&dataList, low: left, high: right)
        quickSort(&dataList, left: left, right: pivotPos - 1)
        quickSort(&dataList, left: pivotPos + 1, right: right)
    }
}

var dataList = [42, 12, 88, 62, 63, 56, 1, 77, 88, 97, 97, 20, 45, 91, 62, 2, 15, 31, 59, 5]

quickSort(&dataList, left: 0, right: dataList.count - 1)

//------------------------------------
// Binary search
//------------------------------------

func binarySearch<T: Comparable>(target: T, collection: [T]) -> Int {
    
    let min = 0
    let max = collection.count - 1
    
    return binaryMakeGuess(min, max: max, target: target, collection: collection)
    
}


func binaryMakeGuess<T: Comparable>(min: Int, max: Int, target: T, collection: [T]) -> Int {
    
    let guess = (min + max) / 2
    
    if max < min {
        
        // illegal, guess not in array
        return -1
        
    } else if collection[guess] == target {
        
        // guess is correct
        return guess
        
    } else if collection[guess] > target {
        
        // guess is too high
        return binaryMakeGuess(min, max: guess - 1, target: target, collection: collection)
        
    } else {
        
        // array[guess] < target
        // guess is too low
        return binaryMakeGuess(guess + 1, max: max, target: target, collection: collection)
        
    }
}


//------------------------------------
// Swapping: Parrallel Assignment
//------------------------------------

func swap(inout a: String, inout b: String, inout c: String){
    (a,b,c) = (c,a,b)
}

var a = "I'm first"
var b = "No, I'm first"
var c = "Comming through"

swap(&a, b: &b, c:&c)
a
b
c

//------------------------------------
// Search Object in Array
//------------------------------------

//data
var array = [42, 12, 88, 62, 63, 56, 1, 77, 88, 97, 97, 20, 45, 91, 62, 2, 15, 31, 59, 5]

// target
var number = 97

// search with filter
let filteredArray = array.filter({$0 == number})

// bruce force search
var filteredArray2:Array<Int> = []
for element in array where element == number {
    filteredArray2.append(element)
}

filteredArray
filteredArray2

// quicksort first
quickSort(&array, left: 0, right: array.count - 1)
// binary search
let resultIndex:Int = binarySearch(number, collection: array)

array[resultIndex]
