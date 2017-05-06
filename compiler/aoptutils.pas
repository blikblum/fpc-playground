{
    Copyright (c) 1998-2016 by Florian Klaempfl and Jonas Maebe

    This unit contains helper procedures for the assembler peephole optimizer

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

 ****************************************************************************
}

unit aoptutils;

{$i fpcdefs.inc}

  interface

    uses
      aasmtai,aasmcpu;

    function MatchOpType(const p : taicpu;type0: toptype) : Boolean;
    function MatchOpType(const p : taicpu;type0,type1 : toptype) : Boolean;

    { skips all labels and returns the next "real" instruction }
    function SkipLabels(hp: tai; var hp2: tai): boolean;

  implementation

    function MatchOpType(const p : taicpu; type0: toptype) : Boolean;
      begin
        Result:=(p.oper[0]^.typ=type0);
      end;


    function MatchOpType(const p : taicpu; type0,type1 : toptype) : Boolean;
      begin
        Result:=(p.oper[0]^.typ=type0) and (p.oper[0]^.typ=type1);
      end;


    { skips all labels and returns the next "real" instruction }
    function SkipLabels(hp: tai; var hp2: tai): boolean;
      begin
        while assigned(hp.next) and
              (tai(hp.next).typ in SkipInstr + [ait_label,ait_align]) Do
          hp := tai(hp.next);
        if assigned(hp.next) then
          begin
            SkipLabels := True;
            hp2 := tai(hp.next)
          end
        else
          begin
            hp2 := hp;
            SkipLabels := False
          end;
      end;


end.

