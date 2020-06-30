class Cell(object):
	EMPTY = 0
	CROSS = 1
	NOUGHT = 2

	def __init__(self):
		self.content = self.EMPTY

	def paint(self):
		if self.content == self.CROSS:
			print('X', end = '')
		elif self.content == self.NOUGHT:
			print('O', end = '')
		else:
			print(' ', end = '')