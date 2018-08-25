#include <stdio.h>

// A node in an AVL tree
typedef struct Node {
	struct Node* left;
	struct Node* right;

	size_t weight;
} Node;


int main() {
	srand(time(NULL));	// Seed the RNG so we have some randomness to work with
}

// Recursively delete tree. This could be done iteratively by saving the state
// while navigating the tree. This is implemented like a DFS
void delete_tree(Node* tree) {
	// If the tree has a left node attached
	if(tree->left) {
		// Delete the left subtree
		delete_tree(tree->left);
	}

	// If the tree has a right subtree attached
	if(tree->right) {
		// Delete the right subtree
		delete_tree(tree->right);
	}

	// Delete this node
	free((void*) tree);
}
