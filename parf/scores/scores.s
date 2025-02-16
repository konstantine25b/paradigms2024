.text
call main
li a0, 10
ecall

# YOUR CODE STARTS HERE
score:

#char score(Score *data, int numScores, ScoreFn fn) {
#    short total = 0;
#    for (int i = 0; i < numScores; i++) {
#        total += fn(ELEM(data[i])->scores);
#    }
#    return total;
#}

addi sp, sp, -16
addi x11, x0, 0
sh x11, 14(sp) # total = 0
sw x11, 10(sp) # i = 0
sw ra, 6(sp) # ra


startloop:

lw x11, 10(sp) # i
lw x12, 20(sp) #numScores

bge x11, x12 , endloop
lh x13, 14(sp) # total
lw x14, 16(sp) # data
addi x15, x0 ,20 # data size
mul x15, x15 , x11 # data offset
lw x16, 0(x14) # dataze vdgavart dereferensi
add x16, x16, x15 # data[i]
addi x17, x16, 4  #ELEM(src) (*((Score **)((char *)src.scores + 3)))
lw x18, 1(x17) #ELEM(data[i])->scores)
lh x19, 1(x17) #scores[0]
sh x19, 4(sp) # davstore scores[0]
lh x19, 3(x17) # scores[1]
sh x19, 2(sp) # davstore scores[1]
lh x19, 5(x17) # scores[2]
sh x19, 0(sp) # davstore scores[2]
lw x19, 24(sp) # fn
jalr x19

lh x12, 14(sp) # total
add x13, x12 , x10 # total+=fn
sh x13, 14(sp)

addi x11, x11, 1 # i++
sw x11, 10(sp) # store i
j startloop # ukan loopshi


endloop:

lb x10, 14(sp) # x10 shi total is chari
lw ra, 6(sp) # ra davabrune
addi sp, sp, 16 # avkece
ret




# DO NOT EDIT ANYTHING BELOW AND INCLUDING THIS LINE
scoreFn1:
        lw a0, 0(sp)

        addi    sp,sp,-32
        sw      ra,28(sp)
        sw      s0,24(sp)
        addi    s0,sp,32
        sw      a0,-20(s0)
        lw      a5,-20(s0)
        lh      a5,0(a5)
        slli    a4,a5,16
        srli    a4,a4,16
        lw      a5,-20(s0)
        addi    a5,a5,2
        lh      a5,0(a5)
        slli    a5,a5,16
        srli    a5,a5,16
        add     a5,a4,a5
        slli    a4,a5,16
        srli    a4,a4,16
        lw      a5,-20(s0)
        addi    a5,a5,4
        lh      a5,0(a5)
        slli    a5,a5,16
        srli    a5,a5,16
        add     a5,a4,a5
        slli    a5,a5,16
        srli    a5,a5,16
        slli    a5,a5,16
        srai    a5,a5,16
        mv      a0,a5
        lw      ra,28(sp)
        lw      s0,24(sp)
        addi    sp,sp,32
        jr      ra
scoreFn2:
        lw a0, 0(sp)

        addi    sp,sp,-32
        sw      ra,28(sp)
        sw      s0,24(sp)
        addi    s0,sp,32
        sw      a0,-20(s0)
        li      a5,100
        mv      a0,a5
        lw      ra,28(sp)
        lw      s0,24(sp)
        addi    sp,sp,32
        jr      ra
ecall:
        addi    sp,sp,-32
        sw      ra,28(sp)
        sw      s0,24(sp)
        addi    s0,sp,32
        sw      a0,-20(s0)
        sw      a1,-24(s0)
        lw      a5,-20(s0)
        mv      a0,a5
        lw      a5,-24(s0)
        mv      a1,a5
        ecall
        nop
        lw      ra,28(sp)
        lw      s0,24(sp)
        addi    sp,sp,32
        jr      ra
.data
.LC0:
        .string "Test 1: "
.LC1:
        .string "Test 2: "
.LC2: 
        .string "Test 3: "
.LC3: 
        .string "Test 4: "
.LC4: 
        .string "Test 5: "
.LC5: 
        .string "Test 6: "
.text
scorewrapper:
        addi sp,sp,-16
        sw ra, 12(sp)
        sw a2, 8(sp)
        sw a1, 4(sp)
        sw a0, 0(sp)
        call score
        lw ra, 12(sp)
        addi sp, sp, 16
        jr ra

main:
        addi    sp,sp,-1344
        sw      ra,1340(sp)
        sw      s0,1336(sp)
        addi    s0,sp,1344
        sw      zero,-20(s0)
        j       .L11
.L12:
        addi    a3,s0,-692
        lw      a4,-20(s0)
        mv      a5,a4
        slli    a5,a5,2
        add     a5,a5,a4
        slli    a5,a5,2
        add     a5,a3,a5
        addi    a5,a5,1
        addi    a3,a5,3
        addi    a2,s0,-1332
        lw      a4,-20(s0)
        mv      a5,a4
        slli    a5,a5,2
        add     a5,a5,a4
        slli    a5,a5,2
        add     a5,a2,a5
        sw      a5,0(a3)
        lw      a5,-20(s0)
        addi    a5,a5,1
        sw      a5,-20(s0)
.L11:
        lw      a4,-20(s0)
        li      a5,31
        ble     a4,a5,.L12
        lbu     a5,-1331(s0)
        andi    a5,a5,0
        ori     a5,a5,13
        sb      a5,-1331(s0)
        lbu     a5,-1330(s0)
        andi    a5,a5,0
        ori     a5,a5,1
        sb      a5,-1330(s0)
        lbu     a5,-1329(s0)
        andi    a5,a5,0
        ori     a5,a5,5
        sb      a5,-1329(s0)
        lbu     a5,-1328(s0)
        andi    a5,a5,0
        ori     a5,a5,1
        sb      a5,-1328(s0)
        lbu     a5,-1327(s0)
        andi    a5,a5,0
        ori     a5,a5,27
        sb      a5,-1327(s0)
        lbu     a5,-1326(s0)
        andi    a5,a5,0
        ori     a5,a5,3
        sb      a5,-1326(s0)
        lbu     a5,-1311(s0)
        andi    a5,a5,0
        ori     a5,a5,-85
        sb      a5,-1311(s0)
        lbu     a5,-1310(s0)
        andi    a5,a5,0
        ori     a5,a5,1
        sb      a5,-1310(s0)
        lbu     a5,-1309(s0)
        andi    a5,a5,0
        ori     a5,a5,39
        sb      a5,-1309(s0)
        lbu     a5,-1308(s0)
        andi    a5,a5,0
        ori     a5,a5,1
        sb      a5,-1308(s0)
        lbu     a5,-1307(s0)
        andi    a5,a5,0
        ori     a5,a5,83
        sb      a5,-1307(s0)
        lbu     a5,-1306(s0)
        andi    a5,a5,0
        sb      a5,-1306(s0)
        lbu     a5,-1291(s0)
        andi    a5,a5,0
        ori     a5,a5,47
        sb      a5,-1291(s0)
        lbu     a5,-1290(s0)
        andi    a5,a5,0
        ori     a5,a5,3
        sb      a5,-1290(s0)
        lbu     a5,-1289(s0)
        andi    a5,a5,0
        ori     a5,a5,-118
        sb      a5,-1289(s0)
        lbu     a5,-1288(s0)
        andi    a5,a5,0
        ori     a5,a5,3
        sb      a5,-1288(s0)
        lbu     a5,-1287(s0)
        andi    a5,a5,0
        ori     a5,a5,64
        sb      a5,-1287(s0)
        lbu     a5,-1286(s0)
        andi    a5,a5,0
        sb      a5,-1286(s0)
        lbu     a5,-1271(s0)
        andi    a5,a5,0
        ori     a5,a5,57
        sb      a5,-1271(s0)
        lbu     a5,-1270(s0)
        andi    a5,a5,0
        ori     a5,a5,1
        sb      a5,-1270(s0)
        lbu     a5,-1269(s0)
        andi    a5,a5,0
        ori     a5,a5,-59
        sb      a5,-1269(s0)
        lbu     a5,-1268(s0)
        andi    a5,a5,0
        sb      a5,-1268(s0)
        lbu     a5,-1267(s0)
        andi    a5,a5,0
        ori     a5,a5,107
        sb      a5,-1267(s0)
        lbu     a5,-1266(s0)
        andi    a5,a5,0
        sb      a5,-1266(s0)
        lbu     a5,-1251(s0)
        andi    a5,a5,0
        ori     a5,a5,-114
        sb      a5,-1251(s0)
        lbu     a5,-1250(s0)
        andi    a5,a5,0
        ori     a5,a5,1
        sb      a5,-1250(s0)
        lbu     a5,-1249(s0)
        andi    a5,a5,0
        ori     a5,a5,-61
        sb      a5,-1249(s0)
        lbu     a5,-1248(s0)
        andi    a5,a5,0
        ori     a5,a5,3
        sb      a5,-1248(s0)
        lbu     a5,-1247(s0)
        andi    a5,a5,0
        ori     a5,a5,15
        sb      a5,-1247(s0)
        lbu     a5,-1246(s0)
        andi    a5,a5,0
        ori     a5,a5,3
        sb      a5,-1246(s0)
        lbu     a5,-1231(s0)
        andi    a5,a5,0
        ori     a5,a5,122
        sb      a5,-1231(s0)
        lbu     a5,-1230(s0)
        andi    a5,a5,0
        sb      a5,-1230(s0)
        lbu     a5,-1229(s0)
        andi    a5,a5,0
        ori     a5,a5,4
        sb      a5,-1229(s0)
        lbu     a5,-1228(s0)
        andi    a5,a5,0
        sb      a5,-1228(s0)
        lbu     a5,-1227(s0)
        andi    a5,a5,0
        ori     a5,a5,-12
        sb      a5,-1227(s0)
        lbu     a5,-1226(s0)
        andi    a5,a5,0
        ori     a5,a5,1
        sb      a5,-1226(s0)
        lbu     a5,-1211(s0)
        andi    a5,a5,0
        ori     a5,a5,54
        sb      a5,-1211(s0)
        lbu     a5,-1210(s0)
        andi    a5,a5,0
        sb      a5,-1210(s0)
        lbu     a5,-1209(s0)
        andi    a5,a5,0
        ori     a5,a5,-70
        sb      a5,-1209(s0)
        lbu     a5,-1208(s0)
        andi    a5,a5,0
        ori     a5,a5,2
        sb      a5,-1208(s0)
        lbu     a5,-1207(s0)
        andi    a5,a5,0
        ori     a5,a5,74
        sb      a5,-1207(s0)
        lbu     a5,-1206(s0)
        andi    a5,a5,0
        ori     a5,a5,3
        sb      a5,-1206(s0)
        lbu     a5,-1191(s0)
        andi    a5,a5,0
        ori     a5,a5,-17
        sb      a5,-1191(s0)
        lbu     a5,-1190(s0)
        andi    a5,a5,0
        ori     a5,a5,1
        sb      a5,-1190(s0)
        lbu     a5,-1189(s0)
        andi    a5,a5,0
        ori     a5,a5,44
        sb      a5,-1189(s0)
        lbu     a5,-1188(s0)
        andi    a5,a5,0
        sb      a5,-1188(s0)
        lbu     a5,-1187(s0)
        andi    a5,a5,0
        ori     a5,a5,16
        sb      a5,-1187(s0)
        lbu     a5,-1186(s0)
        andi    a5,a5,0
        ori     a5,a5,1
        sb      a5,-1186(s0)
        lbu     a5,-1171(s0)
        andi    a5,a5,0
        ori     a5,a5,99
        sb      a5,-1171(s0)
        lbu     a5,-1170(s0)
        andi    a5,a5,0
        sb      a5,-1170(s0)
        lbu     a5,-1169(s0)
        andi    a5,a5,0
        ori     a5,a5,49
        sb      a5,-1169(s0)
        lbu     a5,-1168(s0)
        andi    a5,a5,0
        ori     a5,a5,3
        sb      a5,-1168(s0)
        lbu     a5,-1167(s0)
        andi    a5,a5,0
        ori     a5,a5,74
        sb      a5,-1167(s0)
        lbu     a5,-1166(s0)
        andi    a5,a5,0
        sb      a5,-1166(s0)
        lbu     a5,-1151(s0)
        andi    a5,a5,0
        ori     a5,a5,-25
        sb      a5,-1151(s0)
        lbu     a5,-1150(s0)
        andi    a5,a5,0
        ori     a5,a5,2
        sb      a5,-1150(s0)
        lbu     a5,-1149(s0)
        andi    a5,a5,0
        ori     a5,a5,87
        sb      a5,-1149(s0)
        lbu     a5,-1148(s0)
        andi    a5,a5,0
        ori     a5,a5,1
        sb      a5,-1148(s0)
        lbu     a5,-1147(s0)
        andi    a5,a5,0
        ori     a5,a5,-119
        sb      a5,-1147(s0)
        lbu     a5,-1146(s0)
        andi    a5,a5,0
        ori     a5,a5,2
        sb      a5,-1146(s0)
        lbu     a5,-1131(s0)
        andi    a5,a5,0
        ori     a5,a5,-77
        sb      a5,-1131(s0)
        lbu     a5,-1130(s0)
        andi    a5,a5,0
        ori     a5,a5,1
        sb      a5,-1130(s0)
        lbu     a5,-1129(s0)
        andi    a5,a5,0
        ori     a5,a5,-101
        sb      a5,-1129(s0)
        lbu     a5,-1128(s0)
        andi    a5,a5,0
        ori     a5,a5,1
        sb      a5,-1128(s0)
        lbu     a5,-1127(s0)
        andi    a5,a5,0
        ori     a5,a5,-61
        sb      a5,-1127(s0)
        lbu     a5,-1126(s0)
        andi    a5,a5,0
        sb      a5,-1126(s0)
        lbu     a5,-1111(s0)
        andi    a5,a5,0
        ori     a5,a5,-71
        sb      a5,-1111(s0)
        lbu     a5,-1110(s0)
        andi    a5,a5,0
        ori     a5,a5,2
        sb      a5,-1110(s0)
        lbu     a5,-1109(s0)
        andi    a5,a5,0
        ori     a5,a5,8
        sb      a5,-1109(s0)
        lbu     a5,-1108(s0)
        andi    a5,a5,0
        sb      a5,-1108(s0)
        lbu     a5,-1107(s0)
        andi    a5,a5,0
        ori     a5,a5,125
        sb      a5,-1107(s0)
        lbu     a5,-1106(s0)
        andi    a5,a5,0
        sb      a5,-1106(s0)
        lbu     a5,-1091(s0)
        andi    a5,a5,0
        ori     a5,a5,-114
        sb      a5,-1091(s0)
        lbu     a5,-1090(s0)
        andi    a5,a5,0
        ori     a5,a5,2
        sb      a5,-1090(s0)
        lbu     a5,-1089(s0)
        andi    a5,a5,0
        ori     a5,a5,88
        sb      a5,-1089(s0)
        lbu     a5,-1088(s0)
        andi    a5,a5,0
        sb      a5,-1088(s0)
        lbu     a5,-1087(s0)
        andi    a5,a5,0
        ori     a5,a5,-85
        sb      a5,-1087(s0)
        lbu     a5,-1086(s0)
        andi    a5,a5,0
        ori     a5,a5,3
        sb      a5,-1086(s0)
        lbu     a5,-1071(s0)
        andi    a5,a5,0
        ori     a5,a5,-50
        sb      a5,-1071(s0)
        lbu     a5,-1070(s0)
        andi    a5,a5,0
        sb      a5,-1070(s0)
        lbu     a5,-1069(s0)
        andi    a5,a5,0
        ori     a5,a5,-82
        sb      a5,-1069(s0)
        lbu     a5,-1068(s0)
        andi    a5,a5,0
        ori     a5,a5,1
        sb      a5,-1068(s0)
        lbu     a5,-1067(s0)
        andi    a5,a5,0
        ori     a5,a5,-93
        sb      a5,-1067(s0)
        lbu     a5,-1066(s0)
        andi    a5,a5,0
        ori     a5,a5,1
        sb      a5,-1066(s0)
        lbu     a5,-1051(s0)
        andi    a5,a5,0
        ori     a5,a5,51
        sb      a5,-1051(s0)
        lbu     a5,-1050(s0)
        andi    a5,a5,0
        sb      a5,-1050(s0)
        lbu     a5,-1049(s0)
        andi    a5,a5,0
        ori     a5,a5,65
        sb      a5,-1049(s0)
        lbu     a5,-1048(s0)
        andi    a5,a5,0
        sb      a5,-1048(s0)
        lbu     a5,-1047(s0)
        andi    a5,a5,0
        ori     a5,a5,-20
        sb      a5,-1047(s0)
        lbu     a5,-1046(s0)
        andi    a5,a5,0
        ori     a5,a5,2
        sb      a5,-1046(s0)
        lbu     a5,-1031(s0)
        andi    a5,a5,0
        ori     a5,a5,95
        sb      a5,-1031(s0)
        lbu     a5,-1030(s0)
        andi    a5,a5,0
        ori     a5,a5,2
        sb      a5,-1030(s0)
        lbu     a5,-1029(s0)
        andi    a5,a5,0
        ori     a5,a5,4
        sb      a5,-1029(s0)
        lbu     a5,-1028(s0)
        andi    a5,a5,0
        sb      a5,-1028(s0)
        lbu     a5,-1027(s0)
        andi    a5,a5,0
        ori     a5,a5,70
        sb      a5,-1027(s0)
        lbu     a5,-1026(s0)
        andi    a5,a5,0
        ori     a5,a5,1
        sb      a5,-1026(s0)
        lbu     a5,-1011(s0)
        andi    a5,a5,0
        ori     a5,a5,-6
        sb      a5,-1011(s0)
        lbu     a5,-1010(s0)
        andi    a5,a5,0
        sb      a5,-1010(s0)
        lbu     a5,-1009(s0)
        andi    a5,a5,0
        ori     a5,a5,44
        sb      a5,-1009(s0)
        lbu     a5,-1008(s0)
        andi    a5,a5,0
        sb      a5,-1008(s0)
        lbu     a5,-1007(s0)
        andi    a5,a5,0
        ori     a5,a5,-38
        sb      a5,-1007(s0)
        lbu     a5,-1006(s0)
        andi    a5,a5,0
        ori     a5,a5,3
        sb      a5,-1006(s0)
        lbu     a5,-991(s0)
        andi    a5,a5,0
        ori     a5,a5,81
        sb      a5,-991(s0)
        lbu     a5,-990(s0)
        andi    a5,a5,0
        sb      a5,-990(s0)
        lbu     a5,-989(s0)
        andi    a5,a5,0
        ori     a5,a5,47
        sb      a5,-989(s0)
        lbu     a5,-988(s0)
        andi    a5,a5,0
        ori     a5,a5,2
        sb      a5,-988(s0)
        lbu     a5,-987(s0)
        andi    a5,a5,0
        ori     a5,a5,-102
        sb      a5,-987(s0)
        lbu     a5,-986(s0)
        andi    a5,a5,0
        ori     a5,a5,3
        sb      a5,-986(s0)
        lbu     a5,-971(s0)
        andi    a5,a5,0
        ori     a5,a5,-53
        sb      a5,-971(s0)
        lbu     a5,-970(s0)
        andi    a5,a5,0
        sb      a5,-970(s0)
        lbu     a5,-969(s0)
        andi    a5,a5,0
        ori     a5,a5,-103
        sb      a5,-969(s0)
        lbu     a5,-968(s0)
        andi    a5,a5,0
        ori     a5,a5,2
        sb      a5,-968(s0)
        lbu     a5,-967(s0)
        andi    a5,a5,0
        ori     a5,a5,-88
        sb      a5,-967(s0)
        lbu     a5,-966(s0)
        andi    a5,a5,0
        ori     a5,a5,1
        sb      a5,-966(s0)
        lbu     a5,-951(s0)
        andi    a5,a5,0
        ori     a5,a5,-18
        sb      a5,-951(s0)
        lbu     a5,-950(s0)
        andi    a5,a5,0
        ori     a5,a5,2
        sb      a5,-950(s0)
        lbu     a5,-949(s0)
        andi    a5,a5,0
        ori     a5,a5,-78
        sb      a5,-949(s0)
        lbu     a5,-948(s0)
        andi    a5,a5,0
        ori     a5,a5,1
        sb      a5,-948(s0)
        lbu     a5,-947(s0)
        andi    a5,a5,0
        ori     a5,a5,-88
        sb      a5,-947(s0)
        lbu     a5,-946(s0)
        andi    a5,a5,0
        ori     a5,a5,2
        sb      a5,-946(s0)
        lbu     a5,-931(s0)
        andi    a5,a5,0
        ori     a5,a5,-23
        sb      a5,-931(s0)
        lbu     a5,-930(s0)
        andi    a5,a5,0
        sb      a5,-930(s0)
        lbu     a5,-929(s0)
        andi    a5,a5,0
        ori     a5,a5,-79
        sb      a5,-929(s0)
        lbu     a5,-928(s0)
        andi    a5,a5,0
        ori     a5,a5,2
        sb      a5,-928(s0)
        lbu     a5,-927(s0)
        andi    a5,a5,0
        ori     a5,a5,-75
        sb      a5,-927(s0)
        lbu     a5,-926(s0)
        andi    a5,a5,0
        ori     a5,a5,1
        sb      a5,-926(s0)
        lbu     a5,-911(s0)
        andi    a5,a5,0
        ori     a5,a5,33
        sb      a5,-911(s0)
        lbu     a5,-910(s0)
        andi    a5,a5,0
        ori     a5,a5,3
        sb      a5,-910(s0)
        lbu     a5,-909(s0)
        andi    a5,a5,0
        ori     a5,a5,13
        sb      a5,-909(s0)
        lbu     a5,-908(s0)
        andi    a5,a5,0
        ori     a5,a5,2
        sb      a5,-908(s0)
        lbu     a5,-907(s0)
        andi    a5,a5,0
        ori     a5,a5,36
        sb      a5,-907(s0)
        lbu     a5,-906(s0)
        andi    a5,a5,0
        ori     a5,a5,1
        sb      a5,-906(s0)
        lbu     a5,-891(s0)
        andi    a5,a5,0
        ori     a5,a5,60
        sb      a5,-891(s0)
        lbu     a5,-890(s0)
        andi    a5,a5,0
        ori     a5,a5,1
        sb      a5,-890(s0)
        lbu     a5,-889(s0)
        andi    a5,a5,0
        ori     a5,a5,105
        sb      a5,-889(s0)
        lbu     a5,-888(s0)
        andi    a5,a5,0
        sb      a5,-888(s0)
        lbu     a5,-887(s0)
        andi    a5,a5,0
        ori     a5,a5,66
        sb      a5,-887(s0)
        lbu     a5,-886(s0)
        andi    a5,a5,0
        sb      a5,-886(s0)
        lbu     a5,-871(s0)
        andi    a5,a5,0
        ori     a5,a5,-23
        sb      a5,-871(s0)
        lbu     a5,-870(s0)
        andi    a5,a5,0
        ori     a5,a5,2
        sb      a5,-870(s0)
        lbu     a5,-869(s0)
        andi    a5,a5,0
        ori     a5,a5,-62
        sb      a5,-869(s0)
        lbu     a5,-868(s0)
        andi    a5,a5,0
        ori     a5,a5,3
        sb      a5,-868(s0)
        lbu     a5,-867(s0)
        andi    a5,a5,0
        ori     a5,a5,80
        sb      a5,-867(s0)
        lbu     a5,-866(s0)
        andi    a5,a5,0
        ori     a5,a5,3
        sb      a5,-866(s0)
        lbu     a5,-851(s0)
        andi    a5,a5,0
        ori     a5,a5,66
        sb      a5,-851(s0)
        lbu     a5,-850(s0)
        andi    a5,a5,0
        ori     a5,a5,3
        sb      a5,-850(s0)
        lbu     a5,-849(s0)
        andi    a5,a5,0
        ori     a5,a5,37
        sb      a5,-849(s0)
        lbu     a5,-848(s0)
        andi    a5,a5,0
        ori     a5,a5,2
        sb      a5,-848(s0)
        lbu     a5,-847(s0)
        andi    a5,a5,0
        ori     a5,a5,-127
        sb      a5,-847(s0)
        lbu     a5,-846(s0)
        andi    a5,a5,0
        ori     a5,a5,1
        sb      a5,-846(s0)
        lbu     a5,-831(s0)
        andi    a5,a5,0
        ori     a5,a5,76
        sb      a5,-831(s0)
        lbu     a5,-830(s0)
        andi    a5,a5,0
        ori     a5,a5,1
        sb      a5,-830(s0)
        lbu     a5,-829(s0)
        andi    a5,a5,0
        ori     a5,a5,-42
        sb      a5,-829(s0)
        lbu     a5,-828(s0)
        andi    a5,a5,0
        sb      a5,-828(s0)
        lbu     a5,-827(s0)
        andi    a5,a5,0
        sb      a5,-827(s0)
        lbu     a5,-826(s0)
        andi    a5,a5,0
        ori     a5,a5,3
        sb      a5,-826(s0)
        lbu     a5,-811(s0)
        andi    a5,a5,0
        ori     a5,a5,-45
        sb      a5,-811(s0)
        lbu     a5,-810(s0)
        andi    a5,a5,0
        ori     a5,a5,1
        sb      a5,-810(s0)
        lbu     a5,-809(s0)
        andi    a5,a5,0
        ori     a5,a5,-104
        sb      a5,-809(s0)
        lbu     a5,-808(s0)
        andi    a5,a5,0
        ori     a5,a5,1
        sb      a5,-808(s0)
        lbu     a5,-807(s0)
        andi    a5,a5,0
        ori     a5,a5,-98
        sb      a5,-807(s0)
        lbu     a5,-806(s0)
        andi    a5,a5,0
        ori     a5,a5,2
        sb      a5,-806(s0)
        lbu     a5,-791(s0)
        andi    a5,a5,0
        ori     a5,a5,-107
        sb      a5,-791(s0)
        lbu     a5,-790(s0)
        andi    a5,a5,0
        ori     a5,a5,1
        sb      a5,-790(s0)
        lbu     a5,-789(s0)
        andi    a5,a5,0
        ori     a5,a5,-98
        sb      a5,-789(s0)
        lbu     a5,-788(s0)
        andi    a5,a5,0
        ori     a5,a5,1
        sb      a5,-788(s0)
        lbu     a5,-787(s0)
        andi    a5,a5,0
        ori     a5,a5,-47
        sb      a5,-787(s0)
        lbu     a5,-786(s0)
        andi    a5,a5,0
        ori     a5,a5,2
        sb      a5,-786(s0)
        lbu     a5,-771(s0)
        andi    a5,a5,0
        ori     a5,a5,-87
        sb      a5,-771(s0)
        lbu     a5,-770(s0)
        andi    a5,a5,0
        ori     a5,a5,1
        sb      a5,-770(s0)
        lbu     a5,-769(s0)
        andi    a5,a5,0
        ori     a5,a5,127
        sb      a5,-769(s0)
        lbu     a5,-768(s0)
        andi    a5,a5,0
        sb      a5,-768(s0)
        lbu     a5,-767(s0)
        andi    a5,a5,0
        ori     a5,a5,-110
        sb      a5,-767(s0)
        lbu     a5,-766(s0)
        andi    a5,a5,0
        ori     a5,a5,1
        sb      a5,-766(s0)
        lbu     a5,-751(s0)
        andi    a5,a5,0
        ori     a5,a5,48
        sb      a5,-751(s0)
        lbu     a5,-750(s0)
        andi    a5,a5,0
        ori     a5,a5,2
        sb      a5,-750(s0)
        lbu     a5,-749(s0)
        andi    a5,a5,0
        ori     a5,a5,69
        sb      a5,-749(s0)
        lbu     a5,-748(s0)
        andi    a5,a5,0
        sb      a5,-748(s0)
        lbu     a5,-747(s0)
        andi    a5,a5,0
        ori     a5,a5,43
        sb      a5,-747(s0)
        lbu     a5,-746(s0)
        andi    a5,a5,0
        ori     a5,a5,1
        sb      a5,-746(s0)
        lbu     a5,-731(s0)
        andi    a5,a5,0
        ori     a5,a5,-51
        sb      a5,-731(s0)
        lbu     a5,-730(s0)
        andi    a5,a5,0
        ori     a5,a5,2
        sb      a5,-730(s0)
        lbu     a5,-729(s0)
        andi    a5,a5,0
        ori     a5,a5,122
        sb      a5,-729(s0)
        lbu     a5,-728(s0)
        andi    a5,a5,0
        ori     a5,a5,2
        sb      a5,-728(s0)
        lbu     a5,-727(s0)
        andi    a5,a5,0
        ori     a5,a5,123
        sb      a5,-727(s0)
        lbu     a5,-726(s0)
        andi    a5,a5,0
        ori     a5,a5,3
        sb      a5,-726(s0)
        lbu     a5,-711(s0)
        andi    a5,a5,0
        ori     a5,a5,-119
        sb      a5,-711(s0)
        lbu     a5,-710(s0)
        andi    a5,a5,0
        ori     a5,a5,2
        sb      a5,-710(s0)
        lbu     a5,-709(s0)
        andi    a5,a5,0
        ori     a5,a5,-100
        sb      a5,-709(s0)
        lbu     a5,-708(s0)
        andi    a5,a5,0
        sb      a5,-708(s0)
        lbu     a5,-707(s0)
        andi    a5,a5,0
        ori     a5,a5,122
        sb      a5,-707(s0)
        lbu     a5,-706(s0)
        andi    a5,a5,0
        ori     a5,a5,1
        sb      a5,-706(s0)
        la      a5,.LC0
        mv      a1,a5
        li      a0,4
        call    ecall
        addi    a4,s0,-692
        la      a2,scoreFn1
        li      a1,0
        mv      a0,a4
        call    scorewrapper
        mv      a5,a0
        seqz    a5,a5
        andi    a5,a5,0xff
        mv      a1,a5
        li      a0,1
        call    ecall
        li      a1,10
        li      a0,11
        call    ecall
        la      a5,.LC1
        mv      a1,a5
        li      a0,4
        call    ecall
        addi    a4,s0,-692
        la      a2,scoreFn1
        li      a1,1
        mv      a0,a4
        call    scorewrapper
        mv      a5,a0
        addi    a5,a5,-45
        seqz    a5,a5
        andi    a5,a5,0xff
        mv      a1,a5
        li      a0,1
        call    ecall
        li      a1,10
        li      a0,11
        call    ecall
        la      a5,.LC2
        mv      a1,a5
        li      a0,4
        call    ecall
        addi    a4,s0,-692
        la      a2,scoreFn1
        li      a1,13
        mv      a0,a4
        call    scorewrapper
        mv      a5,a0
        addi    a5,a5,-112
        seqz    a5,a5
        andi    a5,a5,0xff
        mv      a1,a5
        li      a0,1
        call    ecall
        li      a1,10
        li      a0,11
        call    ecall
        la      a5,.LC3
        mv      a1,a5
        li      a0,4
        call    ecall
        addi    a4,s0,-692
        la      a2,scoreFn1
        li      a1,32
        mv      a0,a4
        call    scorewrapper
        mv      a5,a0
        addi    a5,a5,-91
        seqz    a5,a5
        andi    a5,a5,0xff
        mv      a1,a5
        li      a0,1
        call    ecall
        li      a1,10
        li      a0,11
        call    ecall
        la      a5,.LC4
        mv      a1,a5
        li      a0,4
        call    ecall
        addi    a4,s0,-692
        la      a2,scoreFn2
        li      a1,17
        mv      a0,a4
        call    scorewrapper
        mv      a5,a0
        addi    a5,a5,92
        seqz    a5,a5
        andi    a5,a5,0xff
        mv      a1,a5
        li      a0,1
        call    ecall
        li      a1,10
        li      a0,11
        call    ecall
        la      a5,.LC5
        mv      a1,a5
        li      a0,4
        call    ecall
        addi    a4,s0,-692
        la      a2,scoreFn2
        li      a1,32
        mv      a0,a4
        call    scorewrapper
        mv      a5,a0
        addi    a5,a5,128
        seqz    a5,a5
        andi    a5,a5,0xff
        mv      a1,a5
        li      a0,1
        call    ecall
        li      a1,10
        li      a0,11
        call    ecall
        li      a5,0
        mv      a0,a5
        lw      ra,1340(sp)
        lw      s0,1336(sp)
        addi    sp,sp,1344
        jr      ra
