class Case
{
	int number;
	int count;
	String name;
	color col;

	Case(int num)
	{
		number = num;
		count = 0;
    setColor();
	}

	void show(float x, float y, int min, int max)
	{	
		fill(255*(count-min)/(max-min));
		stroke(255);
		rect(x,y,DIM,DIM);
    fill(255,0,0);
    text(count,x,y+DIM/2);
	}

	void setColor()
	{
		switch (number)
    {
  		case 0:  { name = "Via!";					          col = color(127,127,127); } break;
  		case 1:  { name = "Vicolo Corto";			      col = color(80,40,0); 	  } break;
  		case 2:  { name = "Probabilità";			      col = color(60,120,255); 	} break;
  		case 3:  { name = "Vicolo Stretto";			    col = color(80,40,0); 	  } break;
  		case 4:  { name = "Tassa Patrimoniale"; 	  col = color(127,127,127); } break;
  		case 5:  { name = "Stazione Sud";			      col = color(127,127,127); } break;
  		case 6:  { name = "Bastioni Gran Sasso";	  col = color(127,200,255); } break;
  		case 7:  { name = "Imprevisti";				      col = color(60,120,255); 	} break;
  		case 8:  { name = "Viale Monterosa";		    col = color(127,200,255); } break;
  		case 9:  { name = "Viale Vesuvio";			    col = color(127,200,255); } break;
  
  		case 10: { name = "Prigione/Transito";		  col = color(127,127,127); } break;
  		case 11: { name = "Via Accademia"; 			    col = color(255,0,255); 	} break;
  		case 12: { name = "Società Elettrica";		  col = color(127,127,127); } break;
  		case 13: { name = "Corso Ateneo";			      col = color(255,0,255); 	} break;
  		case 14: { name = "Piazza Università";		  col = color(255,0,255); 	} break;
  		case 15: { name = "Stazione Ovest";			    col = color(127,127,127); } break;
  		case 16: { name = "Via Verdi"; 				      col = color(255,127,0); 	} break;
  		case 17: { name = "Probabilità"; 			      col = color(60,120,255); 	} break;
  		case 18: { name = "Corso Raffaello"; 		    col = color(255,127,0); 	} break;
  		case 19: { name = "Piazza Dante"; 			    col = color(255,127,0); 	} break;
  
  		case 20: { name = "Parcheggio Gratuito";	  col = color(127,127,127); } break;
  		case 21: { name = "Via Marco Polo";			    col = color(255,0,0); 	  } break;
  		case 22: { name = "Imprevisti"; 			      col = color(60,120,255); 	} break;
  		case 23: { name = "Corso Magellano"; 		    col = color(255,0,0); 	  } break;
  		case 24: { name = "Largo Colombo"; 			    col = color(255,0,0); 	  } break;
  		case 25: { name = "Stazione Nord"; 			    col = color(127,127,127); } break;
  		case 26: { name = "Viale Costantino"; 	  	col = color(255,255,0); 	} break;
  		case 27: { name = "Viale Traiano"; 			    col = color(255,255,0); 	} break;
  		case 28: { name = "Società Acqua Potabile";	col = color(127,127,127); } break;
  		case 29: { name = "Piazza Giulio Cesare";	  col = color(255,255,0); 	} break;
  
  		case 30: { name = "In Prigione!"; 			    col = color(127,127,127); } break;
  		case 31: { name = "Via Roma"; 			      	col = color(0,255,0); 	  } break;
  		case 32: { name = "Corso Impero"; 		    	col = color(0,255,0); 	  } break;
  		case 33: { name = "Probabilità"; 			      col = color(60,120,255); 	} break;
  		case 34: { name = "Largo Augusto"; 	    		col = color(0,255,0); 	  } break;
  		case 35: { name = "Stazione Est"; 		    	col = color(127,127,127); } break;
  		case 36: { name = "Imprevisti"; 		      	col = color(60,120,255); 	} break;
  		case 37: { name = "Viale Dei Giardini";   	col = color(0,0,255); 	  } break;
  		case 38: { name = "Tassa Di Lusso"; 	    	col = color(0,0,255); 	  } break;
  		case 39: { name = "Parco Della Vittoria";	  col = color(0,0,255); 	  } break;
    }
	}
}