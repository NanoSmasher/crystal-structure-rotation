function fcc100()
	local point = {}
	point[1]	= {x=50		,y=50	,g=1	}
	point[2]	= {x=50		,y=-50	,g=1	}
	point[3]	= {x=-50	,y=50	,g=1	}
	point[4]	= {x=-50	,y=-50	,g=1	}
	point[5]	= {x=150	,y=50	,g=1	}
	point[6]	= {x=150	,y=-50	,g=1	}
	point[7]	= {x=100	,y=0		,v=1}
	point[8]	= {x=0		,y=100		,v=1}
	point[9]	= {x=-100	,y=0		,v=1}
	point[10]	= {x=0		,y=-100		,v=1}
	point[11]	= {x=0		,y=0			}
	point[12]	= {x=100	,y=100			}
	point[13]	= {x=100	,y=-100			}
	point[14]	= {x=-100	,y=100			}
	point[15]	= {x=-100	,y=-100			}
	point[16]	= {x=200	,y=100			}
	point[17]	= {x=200	,y=0			}
	point[18]	= {x=200	,y=-100			}
	return point
end

function fcc110()
	local d = math.sqrt(20000)
	local point = {}
	point[1]	= {x=0		,y=0		,v=1}
	point[2]	= {x=100	,y=0			}
	point[3]	= {x=-100	,y=0			}
	point[4]	= {x=200	,y=0		,v=1}
	point[5]	= {x=-200	,y=0			}
	point[6]	= {x=0		,y=d			}
	point[7]	= {x=100	,y=d			}
	point[8]	= {x=-100	,y=d			}
	point[9]	= {x=200	,y=d			}
	point[10]	= {x=-200	,y=d			}
	point[11]	= {x=200	,y=-d		,v=1}
	point[14]	= {x=0		,y=-d		,v=1}
	point[12]	= {x=100	,y=-d			}
	point[13]	= {x=-100	,y=-d			}
	point[15]	= {x=-200	,y=-d			}
	point[16]	= {x=50		,y=d/2	,g=1	}
	point[17]	= {x=-50	,y=d/2	,g=1	}
	point[18]	= {x=150	,y=d/2	,g=1	}
	point[19]	= {x=-150	,y=d/2	,g=1	}
	point[20]	= {x=50		,y=-d/2	,g=1	}
	point[21]	= {x=-50	,y=-d/2	,g=1	}
	point[22]	= {x=150	,y=-d/2	,g=1	}
	point[23]	= {x=-150	,y=-d/2	,g=1	}
	return point
end

function fcc111()
	local d = 50*math.sqrt(3)
	local m = 50*math.tan(math.pi/6)
	local point = {}
	point[1]	= {x=-250	,y=0			}
	point[2]	= {x=-150	,y=0			}
	point[3]	= {x=-50	,y=0			}
	point[4]	= {x=50		,y=0			}
	point[5]	= {x=150	,y=0			}
	point[6]	= {x=250	,y=0			}
	point[7]	= {x=-200	,y=d			}
	point[8]	= {x=-100	,y=d			}
	point[9]	= {x=0		,y=d		,v=1}
	point[10]	= {x=100	,y=d			}
	point[11]	= {x=200	,y=d			}
	point[12]	= {x=-250	,y=2*d			}
	point[13]	= {x=-150	,y=2*d			}
	point[14]	= {x=-50	,y=2*d			}
	point[15]	= {x=50		,y=2*d			}
	point[16]	= {x=150	,y=2*d			}
	point[17]	= {x=250	,y=2*d			}
	point[18]	= {x=-200	,y=-d			}
	point[19]	= {x=-100	,y=-d		,v=1}
	point[20]	= {x=0		,y=-d			}
	point[21]	= {x=100	,y=-d		,v=1}
	point[22]	= {x=200	,y=-d			}
	point[23]	= {x=-250	,y=-2*d			}
	point[24]	= {x=-150	,y=-2*d			}
	point[25]	= {x=-50	,y=-2*d			}
	point[26]	= {x=50		,y=-2*d			}
	point[27]	= {x=150	,y=-2*d			}
	point[28]	= {x=250	,y=-2*d			}
	point[29]	= {x=-200	,y=m	,g=1	}
	point[30]	= {x=-100	,y=m	,g=1	}
	point[31]	= {x=0		,y=m	,g=1	}
	point[32]	= {x=100	,y=m	,g=1	}
	point[33]	= {x=200	,y=m	,g=1	}
	point[34]	= {x=-150	,y=d+m	,g=1	}
	point[35]	= {x=-50	,y=d+m	,g=1	}
	point[36]	= {x=50		,y=d+m	,g=1	}
	point[37]	= {x=150	,y=d+m	,g=1	}
	return point
end