#!/usr/bin/env ruby1.9.1

def handle(which)
    system("./parse.rb \"#{which}\" > \"#{which.sub('.csv', '.gv')}\"")
    system("dot -T pdf -o \"#{which.sub('.csv', '.pdf')}\" \"#{which.sub('.csv', '.gv')}\"")
#     system("convert \"#{which.sub('.csv', '.pdf')}\" -trim \"#{which.sub('.csv', '.png')}\")
end

handle('die-insel-der-1000-gefahren.csv')
handle('verschollen-im-urwald.csv')
handle('stadt-der-diebe.csv')
