Vim�UnDo� �Go���
]�gX IK����I�5�4Ȍ�   [           &      O       O   O   O    [+��   2 _�                             ����                                                                                                                                                                                                                                                                                                                                                             [+��    �                   5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             [+��     �                  (* stream *)5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             [+��    �                  5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             [+��    �                 Rtype stream = {mutable chr; char option; mutable line num: int; chan: in_channel }5�_�                       5    ����                                                                                                                                                                                                                                                                                                                                                             [+��     �                 Rtype stream = {mutable chr: char option; mutable line num: int; chan: in_channel }5�_�                       5    ����                                                                                                                                                                                                                                                                                                                                                             [+��    �                 Rtype stream = {mutable chr: char option; mutable line+num: int; chan: in_channel }5�_�                       R    ����                                                                                                                                                                                                                                                                                                                                                             [+�      �                 Rtype stream = {mutable chr: char option; mutable line_num: int; chan: in_channel }5�_�      	                      ����                                                                                                                                                                                                                                                                                                                                                             [+�    �                  5�_�      
           	      A    ����                                                                                                                                                                                                                                                                                                                                                             [+�"    �                 Alet open_stream file = {chr=None; line_num=1; chan=open_in file }5�_�   	              
      (    ����                                                                                                                                                                                                                                                                                                                                                             [+�6    �                 (let close_stream stm = close_in stm.chan5�_�   
                 
   >    ����                                                                                                                                                                                                                                                                                                                                                             [+�b     �   	              >                        None -> let c = input_char stm.chan in5�_�                       M    ����                                                                                                                                                                                                                                                                                                                                                             [+��    �                 M                                let _ = stm.line_num <- stm.line_num + 1 in c5�_�                       5    ����                                                                                                                                                                                                                                                                                                                                                             [+��   	 �                 5                        | Some c -> stm.chr <-None; c5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             [+��   
 �                  5�_�                       5    ����                                                                                                                                                                                                                                                                                                                                                             [+��    �               5                        | Some c -> stm.chr <-None; c5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             [+��    �                5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             [+��    �                5�_�                       )    ����                                                                                                                                                                                                                                                                                                                                                             [+��    �                 )let unread_char stm c = stm.chr <- Some c5�_�                       A    ����                                                                                                                                                                                                                                                                                                                                                             [+��    �                 A                code >= Char.code('0') && code <= Char.code ('9')5�_�                       B    ����                                                                                                                                                                                                                                                                                                                                                             [+�=    �                 B                (code >= Char.code('a') && code <= Char.code('z'))5�_�                       	    ����                                                                                                                                                                                                                                                                                                                                                             [+�G    �                 	(*token*)5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             [+�R    �                 type token = Begin | End5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             [+�[    �                         | Identifier of string5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             [+�d    �                         | Read | Write5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             [+�j    �                         | Literal of int5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             [+�n    �                         | Assign5�_�                    "       ����                                                                                                                                                                                                                                                                                                                                                             [+��    �   !   #   #              | AddOp | SubOP5�_�                    #       ����                                                                                                                                                                                                                                                                                                                                                             [+��    �   "                      | Comma | Semicolon5�_�                    %   @    ����                                                                                                                                                                                                                                                                                                                                                             [+��     �   $              @type scanner = { mutable last_token: token option; stm: stream }5�_�                    '        ����                                                                                                                                                                                                                                                                                                                                                             [+��    �   &               5�_�                     '        ����                                                                                                                                                                                                                                                                                                                                                             [+��     �   &               exception Syntax_error of string5�_�      !               )        ����                                                                                                                                                                                                                                                                                                                                                             [+��    �   (               5�_�       "           !   )   a    ����                                                                                                                                                                                                                                                                                                                                                             [+��     �   (              alet syntax_error s msg = raise (Syntax_error(msg ^ " on line " ^ (string_of_int s.stm.line_num)))5�_�   !   #           "   +        ����                                                                                                                                                                                                                                                                                                                                                             [+��    �   *               5�_�   "   $           #   +   ,    ����                                                                                                                                                                                                                                                                                                                                                             [+�    �   *              ,(* skip all blank and new line characters *)5�_�   #   %           $   0   :    ����                                                                                                                                                                                                                                                                                                                                                             [+�l    �   /              :                                else unread_char stm c; ()5�_�   $   &           %   5   8    ����                                                                                                                                                                                                                                                                                                                                                             [+��    �   4              8                then scan_inden(acc ^ (Char.escaped nc))5�_�   %   '           &   <   +    ����                                                                                                                                                                                                                                                                                                                                                             [+�+     �   ;              +                        else Identifier acc5�_�   &   (           '   =       ����                                                                                                                                                                                                                                                                                                                                                             [+�-   ! �   <                              in5�_�   '   )           (   B   3    ����                                                                                                                                                                                                                                                                                                                                                             [+�h   " �   A              3                        Literal (int_of_string acc)5�_�   (   *           )   C       ����                                                                                                                                                                                                                                                                                                                                                             [+�k   # �   B                              in5�_�   )   +           *   D   =    ����                                                                                                                                                                                                                                                                                                                                                             [+��   $ �   C              =                if is_alpha c then scan_iden (Char.escaped c)5�_�   *   ,           +   3       ����                                                                                                                                                                                                                                                                                                                                                             [+��   % �   2   4   E      B                let rec scan_inden acc = let nc = read_char stm in5�_�   +   -           ,   5       ����                                                                                                                                                                                                                                                                                                                                                             [+��   & �   4   6   E      8                then scan_inden(acc ^ (Char.escaped nc))5�_�   ,   .           -   E   A    ����                                                                                                                                                                                                                                                                                                                                                             [+��   ' �   D              A                else if is_digit c then scan_lit (Char.escaped c)5�_�   -   /           .   F   (    ����                                                                                                                                                                                                                                                                                                                                                             [+��     �   F            �   F            5�_�   .   0           /   G       ����                                                                                                                                                                                                                                                                                                                                                             [+��     �   G            �   G            5�_�   /   1           0   H       ����                                                                                                                                                                                                                                                                                                                                                             [+��     �   H            �   H            5�_�   0   2           1   I       ����                                                                                                                                                                                                                                                                                                                                                             [+��     �   I            �   I            5�_�   1   3           2   J       ����                                                                                                                                                                                                                                                                                                                                                             [+��     �   J            �   J            5�_�   2   4           3   G       ����                                                                                                                                                                                                                                                                                                                                                             [+��     �   F   H   K      )                else if c ='+' then AddOp5�_�   3   5           4   H       ����                                                                                                                                                                                                                                                                                                                                                             [+��     �   G   I   K      )                else if c ='+' then AddOp5�_�   4   6           5   I       ����                                                                                                                                                                                                                                                                                                                                                             [+��     �   H   J   K      )                else if c ='+' then AddOp5�_�   5   7           6   I       ����                                                                                                                                                                                                                                                                                                                                                             [+��     �   H   J   K      )                else if c =';' then AddOp5�_�   6   8           7   I       ����                                                                                                                                                                                                                                                                                                                                                             [+��     �   H   J   K      )                else if c ='j' then AddOp5�_�   7   9           8   J       ����                                                                                                                                                                                                                                                                                                                                                             [+�      �   I   K   K      )                else if c ='+' then AddOp5�_�   8   :           9   K       ����                                                                                                                                                                                                                                                                                                                                                             [+�     �   J              )                else if c ='+' then AddOp5�_�   9   ;           :   K       ����                                                                                                                                                                                                                                                                                                                                                             [+�     �   J              )                else if c =';' then AddOp5�_�   :   <           ;   G   $    ����                                                                                                                                                                                                                                                                                                                                                             [+�	     �   F   H   K      )                else if c ='-' then AddOp5�_�   ;   =           <   H   $    ����                                                                                                                                                                                                                                                                                                                                                             [+�     �   G   I   K      )                else if c =',' then AddOp5�_�   <   >           =   I   #    ����                                                                                                                                                                                                                                                                                                                                                             [+�     �   H   J   K      )                else if c ='(' then AddOp5�_�   =   ?           >   H   (    ����                                                                                                                                                                                                                                                                                                                                                             [+�     �   H   J   K    �   H   I   K    5�_�   >   @           ?   I       ����                                                                                                                                                                                                                                                                                                                                                             [+�     �   H   J   L      )                else if c =',' then Comma5�_�   ?   A           @   I   $    ����                                                                                                                                                                                                                                                                                                                                                             [+�   ( �   H   J   L      )                else if c =';' then Comma5�_�   @   B           A   K   $    ����                                                                                                                                                                                                                                                                                                                                                             [+�$     �   J   L   L      )                else if c =')' then AddOp5�_�   A   C           B   K   $    ����                                                                                                                                                                                                                                                                                                                                                             [+�%     �   J   L   L      $                else if c =')' then 5�_�   B   D           C   L   $    ����                                                                                                                                                                                                                                                                                                                                                             [+�(     �   K              )                else if c =':' then AddOp5�_�   C   E           D   L   $    ����                                                                                                                                                                                                                                                                                                                                                             [+�,   ) �   K              $                else if c =':' then 5�_�   D   F           E   L   A    ����                                                                                                                                                                                                                                                                                                                                                             [+�9   * �   K              A                else if c =':' && read_char stm = '=' then Assign5�_�   E   G           F   M   A    ����                                                                                                                                                                                                                                                                                                                                                             [+�I   + �   L              A                else syntax_error s "couldn't identify the token"5�_�   F   H           G   O   ,    ����                                                                                                                                                                                                                                                                                                                                                             [+�h     �   N              ,new_scanner stm = {last_token=None; stm=stm}5�_�   G   I           H   Q        ����                                                                                                                                                                                                                                                                                                                                                             [+�i   , �   P               5�_�   H   J           I   O        ����                                                                                                                                                                                                                                                                                                                                                             [+��   - �   N   P   R      ,new_scanner stm = {last_token=None; stm=stm}5�_�   I   K           J   O       ����                                                                                                                                                                                                                                                                                                                                                             [+��     �   N   P   R      @                let new_scanner stm = {last_token=None; stm=stm}5�_�   J   L           K   O       ����                                                                                                                                                                                                                                                                                                                                                             [+��     �   N   P   R      8        let new_scanner stm = {last_token=None; stm=stm}5�_�   K   M           L   Q        ����                                                                                                                                                                                                                                                                                                                                                             [+��   . �   P   R   R      &match_next s = match s.last_token with5�_�   L   N           M   R   8    ����                                                                                                                                                                                                                                                                                                                                                             [+��   / �   Q              8        None -> let _ = skip_blank_chars s.stm in scan s5�_�   M   O           N   S   -    ����                                                                                                                                                                                                                                                                                                                                                             [+��   0 �   R              -        | Some tn -> s.last_token <- None; tn5�_�   N               O   U   &    ����                                                                                                                                                                                                                                                                                                                                                             [+��   2 �   T              &let match_token s t = match_next s = t5��