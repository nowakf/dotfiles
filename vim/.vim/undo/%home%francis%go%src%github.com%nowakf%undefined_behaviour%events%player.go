Vim�UnDo� ��|uK|Y�-`1���Z[QK�����8��>!   (                                   [#u�    _�                             ����                                                                                                                                                                                                                                                                                                                                                             [#u�     �                import w "ub/events/world"5�_�                             ����                                                                                                                                                                                                                                                                                                                                                             [#u�    �               (   package events       >import w "/github.com/nowakf/undefined_behaviour/events/world"       type Player struct {   	newsFeed []*w.Record   	mailBox  []*w.Record   	IsNew    bool   
	*w.Person   }       func LoadPlayer() *Player {   	return new(Player)   }   ,func NewPlayer(conf *PlayerConfig) *Player {   	p := new(Player)   !	p.mailBox = make([]*w.Record, 0)   	p.IsNew = true   		return p   }       Kfunc (p *Player) feed(viewer chan *w.Record, list []*w.Record) func() int {   	unviewed := 0   	return func() int {   )		for i := unviewed; i < len(list); i++ {   			viewer <- list[i]   			unviewed++   		}   		return unviewed   	}   }       9func (p *Player) News(viewer chan *w.Record) func() int {   !	return p.feed(viewer, p.mailBox)   }   9func (p *Player) Mail(viewer chan *w.Record) func() int {   "	return p.feed(viewer, p.newsFeed)   }       type PlayerConfig struct{}5��