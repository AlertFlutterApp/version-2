import pygame , sys
pygame.init()

win = pygame.display.set_mode((1200, 800), 0, 0, 0)
win.fill((255,255,255))
bg = pygame.image.load("C:/Users/ab135/OneDrive/Desktop/sam/amin.jpg")
bg1 = pygame.transform.scale(bg, (1200,800))
win.blit(bg1,(0,0))
pygame.display.set_caption("boss boss")
red = (115,5,5)
yelow = (5,115,5)
#pygame.draw.rect(win,(255,255,255),(0,0,1200,800),0)
# pygame.draw.rect(win,red,(50,50,100,100),0)
#pygame.display.update()
# pygame.draw.circle(win, yelow, (500,500), 100, 0)
# pygame.draw.ellipse(win, yelow, (200,600,200,80), 0)
# pygame.draw.polygon(win, (255,255,0), [(200,200),(200,300),(400,400),(300,200)], 0)
# pygame.draw.arc(win, (0,0,255), (600,200,100,100), 1, 3, 3)
# pygame.draw.line(win, (255,0,255), (100,100), (900,800), 4)
icon = pygame.image.load("C:/Users/ab135/OneDrive/Desktop/ac.png")
pygame.display.set_icon(icon)
font = pygame.font.Font(None, 200)
text = "خاک بر سر "
t_s = font.render(text,True,(0,255,255))
win.blit(t_s,(130,300))



pygame.display.update()

while True :
    for event in pygame.event.get():
        # print(event)
        if event.type == pygame.QUIT :
            pygame.quit()
            sys.exit()