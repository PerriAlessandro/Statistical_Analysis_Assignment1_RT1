
import time
from sr.robot import *
import math

class Analiser:
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
		
	def collect_distances(self):
		self.find_obstacles()
		string= str(self.dist_left)+" "+str(self.dist_front)+" "+str(self.dist_right)+"\n"
		if self.c<=(self.n_tokens*5):
			self.f.write(string)
		

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
	
	def collect_lap_time(self,start,end):
		if self.c<=self.n_tokens*3:
			self.f2.write(str(end-start)+"\n")
			self.f2.flush()
			self.c=self.c+1
		
		
		
