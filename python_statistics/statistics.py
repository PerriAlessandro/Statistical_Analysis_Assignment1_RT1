
import time
from sr.robot import *
import math

class Analiser:
	#Args: robot (Robot): instance of Robot class
	#      n_tokens (int): number of tokens in the circuit
	#      script (int): integer used to distinguish between the two (or more) scripts
	#      occurrence (int): integer used to distinguish between the i-th occurrence of each script	
	def __init__(self,robot,n_tokens,script,occurrence):
		self.robot=robot
		self.f = open("stats/distances"+str(script)+str(occurrence)+".txt", "w")
		self.f2 = open("stats/lapTime"+str(script)+str(occurrence)+".txt", "w")

		self.f2.write(str(n_tokens)+"\n") #write on the first line of the file the number of silver tokens in the circuit
		self.dist_left=100
		self.dist_front=100
		self.dist_right=100
		self.n_tokens=n_tokens
		self.c=0

	#function to write left, frontal and right closest distance to a .txt file	
	def collect_distances(self):
		self.find_obstacles()
		string= str(self.dist_left)+" "+str(self.dist_front)+" "+str(self.dist_right)+"\n"
		if self.c<=(self.n_tokens*5):
			self.f.write(string)
		
	#function to detect the distance of golden tokens ("range_front" and "range_lat" express 
	#respectively the frontal and the lateral range in degrees that has to be detected) 
	def find_obstacles(self,range_front=30,range_lat=[80,100]):
		
		self.dist_left=self.dist_right=self.dist_front= 100
		
		for token in self.robot.see():
			if(token.info.marker_type is MARKER_TOKEN_GOLD and token.dist < 2.5):
			
				if token.dist < self.dist_front and -range_front < token.rot_y < +range_front:
				    self.dist_front=token.dist
				if token.dist < self.dist_left and -range_lat[1] < token.rot_y < -range_lat[0] :
				    self.dist_left = token.dist
				 
				if token.dist < self.dist_right and range_lat[0] < token.rot_y < range_lat[1] :
				    self.dist_right = token.dist
				
				
		return self.dist_front,self.dist_left,self.dist_right
	
	#function to write the timestamp of each grabbed token to a .txt file. 
	#("start", "end" must be "time.time()" instances of the Time class)
	def collect_lap_time(self,start,end):
		if self.c<=self.n_tokens*3:
			self.f2.write(str(end-start)+"\n")
			self.f2.flush()
			self.c=self.c+1
		
		
		
