<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="sideBar">	
    <!-- Sidebar -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

      <!-- Sidebar - Brand -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="/">
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">Board</div>
      </a>

      <!-- Divider -->
      <hr class="sidebar-divider my-0">

      <!-- Nav Item - Dashboard -->
      <li class="nav-item" v-bind:class="{active : selector == 0}">
        <a class="nav-link" href="/">
          <i class="fas fa-fw fa-tachometer-alt"></i>
          <span>HOME</span></a>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider">

      <!-- Heading -->
<!--       <div class="sidebar-heading"> -->
<!--         Interface -->
<!--       </div> -->

      <!-- Nav Item - Pages Collapse Menu -->
<!--       <li class="nav-item"> -->
<!--         <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo"> -->
<!--           <i class="fas fa-fw fa-cog"></i> -->
<!--           <span>Components</span> -->
<!--         </a> -->
<!--         <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar"> -->
<!--           <div class="bg-white py-2 collapse-inner rounded"> -->
<!--             <h6 class="collapse-header">Custom Components:</h6> -->
<!--             <a class="collapse-item" href="buttons.html">Buttons</a> -->
<!--             <a class="collapse-item" href="cards.html">Cards</a> -->
<!--           </div> -->
<!--         </div> -->
<!--       </li> -->
      
      <li class="nav-item" v-for="parent in cateList" v-if="parent.bcRoot == '#' && memInfo.mrCtg >= parent.bcRating" :class="{active : pselector == parent.bcCode }">
      
		<!-- a태그 collapsed 지우기 -->
        <a class="nav-link collapsed" href="#" data-toggle="collapse" v-bind:data-target="'#collapseTwo' + parent.bcCode" aria-expanded="false" aria-controls="collapseTwo">
          <i class="fas fa-fw fa-table"></i>
          <span>{{parent.bcTitle}}({{parent.bdSum}})</span>
        </a>
        
        <div v-bind:id="'collapseTwo' + parent.bcCode" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar" v-bind:class="{show : pselector == parent.bcCode}">
          <div class="bg-white py-2 collapse-inner rounded">
            <a href="#" class="collapse-item" v-for="child in parent.child" v-if="memInfo.mrCtg >= child.bcRating" v-on:click="goBoard(child, parent.bcCode)" v-bind:class="{active : selector == child.bcCode}">{{child.bcTitle}}({{child.bdSum}})</a> 
            <span class="collapse-item" v-if="parent.child == 0">카테고리가 없습니다.</span>
          </div>
        </div>
      </li>
      
      <!-- Divider -->
		<div v-if="memInfo.mrCtg == 90">
	      <hr class="sidebar-divider">
	
	      <li class="nav-item" :class="{active : pselector == 20000}">
	        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages" aria-expanded="true" aria-controls="collapsePages">
	          <i class="fas fa-fw fa-cog"></i>
	          <span>통합 관리</span>
	        </a>
	        <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar" v-bind:class="{show : pselector == 20000}">
	          <div class="bg-white py-2 collapse-inner rounded">
	            <a class="collapse-item" href="/cateManage" v-bind:class="{active : selector == 10000}">카테고리 관리</a>
	            <a class="collapse-item" href="/userManage" v-bind:class="{active : selector == 15000}">회원 관리</a>
	          </div>
	        </div>
	      </li>
		</div>
      <!-- Nav Item - Utilities Collapse Menu -->
<!--       <li class="nav-item"> -->
<!--         <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities" aria-expanded="true" aria-controls="collapseUtilities"> -->
<!--           <i class="fas fa-fw fa-wrench"></i> -->
<!--           <span>Utilities</span> -->
<!--         </a> -->
<!--         <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar"> -->
<!--           <div class="bg-white py-2 collapse-inner rounded"> -->
<!--             <h6 class="collapse-header">Custom Utilities:</h6> -->
<!--             <a class="collapse-item" href="utilities-color.html">Colors</a> -->
<!--             <a class="collapse-item" href="utilities-border.html">Borders</a> -->
<!--             <a class="collapse-item" href="utilities-animation.html">Animations</a> -->
<!--             <a class="collapse-item" href="utilities-other.html">Other</a> -->
<!--           </div> -->
<!--         </div> -->
<!--       </li> -->

      <!-- Divider -->
<!--       <hr class="sidebar-divider"> -->

      <!-- Heading -->
<!--       <div class="sidebar-heading"> -->
<!--         Addons -->
<!--       </div> -->

      <!-- Nav Item - Pages Collapse Menu -->
<!--       <li class="nav-item"> -->
<!--         <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages" aria-expanded="true" aria-controls="collapsePages"> -->
<!--           <i class="fas fa-fw fa-cog"></i> -->
<!--           <span>통합 관리</span> -->
<!--         </a> -->
<!--         <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar"> -->
<!--           <div class="bg-white py-2 collapse-inner rounded"> -->
<!--             <a class="collapse-item" href="/cateManage">카테고리 관리</a> -->
<!--             <a class="collapse-item" href="/">회원 관리</a> -->
<!--           </div> -->
<!--         </div> -->
<!--       </li> -->

      <!-- Nav Item - Charts -->
<!--       <li class="nav-item"> -->
<!--         <a class="nav-link" href="/boardView"> -->
<!--           <i class="fas fa-fw fa-chart-area"></i> -->
<!--           <span>Charts</span></a> -->
<!--       </li> -->

      <!-- Nav Item - Tables -->
<!--       <li class="nav-item"> -->
<!--         <a class="nav-link" href="/board"> -->
<!--           <i class="fas fa-fw fa-table"></i> -->
<!--           <span>Tables</span></a> -->
<!--       </li> -->

      <!-- Divider -->
<!--       <hr class="sidebar-divider d-none d-md-block"> -->

      <!-- Sidebar Toggler (Sidebar) -->
<!--       <div class="text-center d-none d-md-inline"> -->
<!--         <button class="rounded-circle border-0" id="sidebarToggle"></button> -->
<!--       </div> -->

    </ul>
    <!-- End of Sidebar -->
</div>    


<jsp:include page="/WEB-INF/view/main/script/sideBarScript.jsp"></jsp:include>