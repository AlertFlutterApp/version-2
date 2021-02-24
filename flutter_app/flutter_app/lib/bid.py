import pygame ,sys

pygame.init()

width = 1400
height = 850
white  = (255,255,255)
col1 = (0,200,155)
x_rec , y_rec = 350,750
speed = 1
fps = 15
bg = pygame.image.load("C:/Users/ab135/OneDrive/Desktop/sam/ballon.jpg")
bg = pygame.transform.scale(bg, (1400, 850))

clock = pygame.time.Clock()

win = pygame.display.set_mode((width, height))
pygame.display.set_caption("bia bala")
runing = True

while runing :
    for event in pygame.event.get() :
        if event.type == pygame.QUIT :
            runing = False
            pygame.quit()
            sys.exit()
    win.blit(bg,(0,0))
    pygame.draw.rect(win, col1, (x_rec,y_rec,100,100), 0)    
    if x_rec >= 0 and y_rec == 750 :
        x_rec += speed
    if x_rec == 1300 and y_rec <= 750 :
        y_rec -= speed
    if x_rec <= 1300 and y_rec == 0 :
        x_rec -= speed
    if x_rec == 0 and y_rec <= 750 :
        y_rec += speed


    pygame.display.update() 
pygame.quit()
clock.tick(fps)




pygame.display.update()