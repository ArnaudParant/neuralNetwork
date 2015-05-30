NAME :=		neuralNetwork

HS :=		maths.hs	\
		layer.hs	\
		neuron.hs	\
		main.hs

GHC :=		ghc

RM :=		rm -fv

all:		$(NAME)

re:		clean all

$(NAME):
		$(GHC) $(HS) -o $@

.SUFFIXES:	.hs .hi .o

clean:
		@$(RM) *.o
		@$(RM) $(NAME)