Class {
	#name : #PrintingTITest,
	#superclass : #TITest,
	#category : #'OOTypeInference-Tests'
}

{ #category : #tests }
PrintingTITest >> testTypePrinting1 [
	| prettyPrintA prettyPrintB t1 t2 |
	"test that ('a -> 'b) -> ('a -> 'b) is the same string as ('a -> 'b) -> ('a -> 'b)"
	t1 := TVar newvar.
	t2 := TVar newvar.
	prettyPrintA := (TVar tv: (TArrow type: t1 arrow: t2)) asString.
	prettyPrintB := (TArrow type: t1 arrow: t2) asString.  
	self assert: prettyPrintA = prettyPrintB.

]

{ #category : #tests }
PrintingTITest >> testTypePrinting2 [
	| prettyPrintA prettyPrintB t1 t2 |
	"test that ('a -> 'b) -> ('a -> 'b) is the same string as ('a -> 'b) -> ('a -> 'b)"
	t1 := TVar newvar.
	t2 := TVar newvar.
	prettyPrintA := (TArrow type: (TArrow type: t1 arrow: t2) arrow: (TArrow type: t1 arrow: t2)) asString.
	prettyPrintB := (TArrow type: (TArrow type: t1 arrow: t2) arrow: (TArrow type: t1 arrow: t2)) asString.  
	self assert: prettyPrintA = prettyPrintB.

]

{ #category : #tests }
PrintingTITest >> testTypePrinting3 [
	| prettyPrintA prettyPrintB t1 t2 nestedTArrow |
	"test that ('a -> 'b) -> ('a -> 'b) is the same string as ('a -> 'b) -> ('a -> 'b) 
	even though one ToyTArrow is nested in a ToyTVar"
	t1 := TVar newvar.
	t2 := TVar newvar.
	nestedTArrow := TVar tv: (TArrow type: t1 arrow: t2).
	prettyPrintA := (TArrow type: (TArrow type: t1 arrow: t2) arrow: nestedTArrow) asString.
	prettyPrintB := (TArrow type: (TArrow type: t1 arrow: t2) arrow: (TArrow type: t1 arrow: t2)) asString.  
	self assert: prettyPrintA = prettyPrintB.

]

{ #category : #tests }
PrintingTITest >> testTypePrinting4 [
	| prettyPrintA prettyPrintB t1 t2 nestedTArrow |
	"test that ('a -> 'b) -> ('a -> 'b) is the same string as ('a -> 'b) -> ('a -> 'b) 
	even though one ToyTArrow is nested in a ToyTVar"
	t1 := TVar newvar.
	t2 := TVar newvar.
	nestedTArrow := TVar tv: (TArrow type: t1 arrow: t2).
	prettyPrintA := (TArrow type: nestedTArrow arrow: (TArrow type: t1 arrow: t2)) asString.
	prettyPrintB := (TArrow type: (TArrow type: t1 arrow: t2) arrow: (TArrow type: t1 arrow: t2)) asString.  
	self assert: prettyPrintA = prettyPrintB.

]

{ #category : #tests }
PrintingTITest >> testTypePrinting5 [
	| prettyPrintA prettyPrintB t1 t2 t3 t4 nestedTArrow |
	"test that ('a -> 'b) -> ('a -> 'b) is the same string as ('a -> 'b) -> ('a -> 'b) 
	even though one ToyTArrow is nested in a ToyTVar"
	t1 := TVar newvar.
	t2 := TVar newvar.
	t3 := TVar newvar.
	t4 := TVar newvar.
	nestedTArrow := TVar tv: (TArrow type: t3 arrow: t4).
	prettyPrintA := (TArrow type: (TArrow type: t1 arrow: t2) arrow: nestedTArrow) asString.
	prettyPrintB := (TArrow type: (TArrow type: t1 arrow: t2) arrow: (TArrow type: t3 arrow: t4)) asString.  
	self assert: prettyPrintA = prettyPrintB.

]
