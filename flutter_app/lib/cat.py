import pygame ,sys

pygame.init()

width = 1400
height = 850
white  = (255,255,255)
col1 = (0,200,155)
x_rec , y_rec = 350,350
speed = 5
fps = 15
bg = pygame.image.load("C:/Users/ab135/OneDrive/Desktop/sam/ballon.jpg")
bg = pygame.transform.scale(bg, (1400, 850))
char = pygame.image.load("C:/Users/ab135/OneDrive/Desktop/sam/messi.png")
char = pygame.transform.scale(char, (200, 200))

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
        if event.type == pygame.KEYDOWN :
            if event.key == pygame.K_d :
                x_rec += speed
            if event.key == pygame.K_a :
                x_rec -= speed
            if event.key == pygame.K_s :
                y_rec += speed
            if event.key == pygame.K_w :
                y_rec -= speed




    win.blit(bg,(0,0))
    win.blit(char,(x_rec,y_rec))
    

    pygame.display.update() 
pygame.quit()
clock.tick(fps)




pygame.display.update()