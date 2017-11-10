<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../../taglib/taglibs.jsp" %>
<%@ include file="../../../taglib/import_iview.jsp" %>
<%@ include file="../../../taglib/import_jquery.jsp" %>
<%@ include file="../../../taglib/import_common.jsp" %>
<html>
<head>
    <title>锁屏测试代码</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" media="screen"/>
    <link rel="stylesheet" href="${ctx}/css/lock/unlock.css">
</head>
<body>
<div class="my-app" id="app">
    <div class="lockmain" :class="{'lockmain-hide': hideText}">
        <div style="width: 100%;height: 100%;background: #667aa6">
            <div class="unlock-con">
                <unlock :show-unlock="showUnlock" @on-unlock="unlockScreen"></unlock>
            </div>
        </div>
     </div>
     <div class="lock-screen-back" id="lock_screen_back"></div>
</body>
<script>
    // 注册锁屏组件
    Vue.component('unlock', {
        name: 'Unlock',
        template: `
             <transition name="show-unlock">
             <div class="unlock-body-con" v-if="showUnlock" @keydown.enter="handleUnlock">
                <div @click="handleClickAvator" class="unlock-avator-con" :style="{marginLeft: avatorLeft}">
                    <img class="unlock-avator-img" :src="avatorPath">
                    <div  class="unlock-avator-cover">
                        <span><Icon type="unlocked" :size="30"></Icon></span>
                        <p>解锁</p>
                    </div>
                </div>
                <div class="unlock-avator-under-back" :style="{marginLeft: avatorLeft}"></div>
                <div class="unlock-input-con">
                    <div class="unlock-input-overflow-con">
                        <div class="unlock-overflow-body" :style="{right: inputLeft}">
                            <input ref="inputEle" v-model="password" class="unlock-input" type="password" placeholder="密码同登录密码" />
                            <button ref="unlockBtn" @mousedown="unlockMousedown" @mouseup="unlockMouseup" @click="handleUnlock" class="unlock-btn"><Icon color="white" type="key"></Icon></button>
                        </div>
                    </div>
                </div>
                <div class="unlock-locking-tip-con">已锁定</div>
            </div>
        </transition>
         `,
        data () {
            return {
                avatorLeft: '0px',
                inputLeft: '400px',
                password: ''
            };
        },
        props: {
            showUnlock: {
                type: Boolean,
                default: false
            }
        },
        computed: {
            avatorPath () {
                return localStorage.avatorImgPath;
            }
        },
        methods: {
            handleClickAvator () {
                this.avatorLeft = '-180px';
                this.inputLeft = '0px';
                this.$refs.inputEle.focus();
            },
            handleUnlock () {
                this.avatorLeft = '0px';
                this.inputLeft = '400px';
                this.password = '';
                this.$Message.error('登录成功');
                this.$emit('on-unlock');
            },
            unlockMousedown () {
                this.$refs.unlockBtn.className = 'unlock-btn click-unlock-btn';
            },
            unlockMouseup () {
                this.$refs.unlockBtn.className = 'unlock-btn';
            }
        }
    });

    new Vue({
          el: '#app',
          data () {
              return {
                  showUnlock: false,
                  lockScreenSize: 0,
                  hideText:true
              };
          },
          methods: {
              unlockScreen () {
                  let lockScreenBack = document.getElementById('lock_screen_back');
                  this.showUnlock = false;
                  this.hideText=true;
                  lockScreenBack.style.zIndex = -1;
                  lockScreenBack.style.boxShadow = '0 0 0 0 #667aa6 inset';
              },
              lockScreen () {
                  let lockScreenBack = document.getElementById('lock_screen_back');
                  lockScreenBack.style.transition = 'all 3s';
                  lockScreenBack.style.zIndex = 10000;
                  lockScreenBack.style.boxShadow = '0 0 0 ' + this.lockScreenSize + 'px #667aa6 inset';
                  this.showUnlock = true;
                  setTimeout(() => {
                      this.hideText=false;
                      lockScreenBack.style.transition = 'all 0s';
                      lockScreenBack.style.zIndex = -1;
                  }, 800);
              }
          },
          mounted () {
              // 锁屏相关
              let lockScreenBack = document.getElementById('lock_screen_back');
              let x = document.body.clientWidth;
              let y = document.body.clientHeight;
              let r = Math.sqrt(x * x + y * y);
              let size = parseInt(r);
              this.lockScreenSize = size;
              window.addEventListener('resize', () => {
                  let x = document.body.clientWidth;
                  let y = document.body.clientHeight;
                  let r = Math.sqrt(x * x + y * y);
                  let size = parseInt(r);
                  this.lockScreenSize = size;
                  lockScreenBack.style.transition = 'all 0s';
                  lockScreenBack.style.width = lockScreenBack.style.height = size + 'px';
              });
              lockScreenBack.style.width = lockScreenBack.style.height = size + 'px';

              setTimeout(() => {
                  this.lockScreen();
              }, 5000);

          }
        });
</script>
</html>
