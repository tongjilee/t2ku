# -*- encoding : utf-8 -*-
class TasksController < InheritedResources::Base
  def new
    @randoms = [
#		  'Let $X$ be a set. Let $1$ be the identity function on $X$. Let $\alpha$ be a permutation of $X$. Prove that \[1\alpha=\alpha=\alpha 1.\]'
#			'Prove that $X\cup X=X$.'
<<CODEHERE
Let $G$ be a group,
    $e$ be the identity of $G$,
    $*$ be the binary operation of $G$.
Suppose that
    $x*x=e$ for all $x\\in G$.
Prove that
    $G$ is commutative.
CODEHERE
		]
    new!
  end
end
