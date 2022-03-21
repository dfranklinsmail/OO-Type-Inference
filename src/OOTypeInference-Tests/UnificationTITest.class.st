Class {
	#name : #UnificationTITest,
	#superclass : #TITest,
	#category : #'OOTypeInference-Tests'
}

{ #category : #tests }
UnificationTITest >> testBaseTypeUnificaiton [
	"What happens when a Char, Int, Bool or Obj are unified?"	
	| c1 c2 |
	c1 := Char new.
	c2 := Char new.
	
	self assert: c1 equals: c2.
]
