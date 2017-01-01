//
//  MatrixSubscripting.swift
//  SwiftNum
//
//  Created by Donald Pinckney on 1/1/17.
//
//

public extension Matrix {
    public subscript(row: Int, column: Int) -> Double {
        get {
            return data[width*row + column]
        }
        set(val) {
            data[width*row + column] = val
        }
    }
    
    public subscript(rows: Range<Int>, columns: Range<Int>) -> Matrix {
        get {
            let width = columns.count
            let height = rows.count
            var values: [Double] = [Double](repeating: 0, count: width * height)
            
            for r in rows.lowerBound..<rows.upperBound {
                let base = (r - rows.lowerBound) * width
                let selfBase = r * self.width + columns.lowerBound
                let selfEnd = r * self.width + columns.upperBound
                values[base..<(base + width)] = data[selfBase..<selfEnd]
            }
            return Matrix(rowMajorData: values, width: width)
        }
        set(subMatrix) {
            precondition(rows.count == subMatrix.height)
            precondition(columns.count == subMatrix.width)
            
            let width = columns.count
            
            for r in rows.lowerBound..<rows.upperBound {
                let base = (r - rows.lowerBound) * width
                let selfBase = r * self.width + columns.lowerBound
                let selfEnd = r * self.width + columns.upperBound
                data[selfBase..<selfEnd] = subMatrix.data[base..<(base + width)]
            }
        }
    }
    public subscript(rows: ClosedRange<Int>, columns: Range<Int>) -> Matrix {
        get {
            return self[Range(rows), columns]
        }
        set(m) {
            self[Range(rows), columns] = m
        }
    }
    public subscript(rows: Range<Int>, columns: ClosedRange<Int>) -> Matrix {
        get {
            return self[rows, Range(columns)]
        }
        set(m) {
            self[rows, Range(columns)] = m
        }
    }
    public subscript(rows: ClosedRange<Int>, columns: ClosedRange<Int>) -> Matrix {
        get {
            return self[Range(rows), Range(columns)]
        }
        set(m) {
            self[Range(rows), Range(columns)] = m
        }
    }
}