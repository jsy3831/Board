<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

        <div class="container-fluid" id="cateManage">
          <div class="col-lg-7">
          		<div class="card shadow mb-4">
		            <div class="card-header py-3">
		              <h6 class="m-0 font-weight-bold text-primary">카테고리 관리</h6>
		            </div>
		            <div class="card-body">
						<div class="navbar-nav sidebar" style="min-height: auto; width:100%!important" id="aa">
							<div class="nav-item" v-for="plist in list" v-if="plist.bcRoot == '#'">
						    	<div v-on:mouseover="showIcon(plist.bcCode,1)" v-on:mouseout="hideIcon(plist.bcCode,1)">
							    	<a href="#" class="nav-link collapsed" v-bind:id="'list' + plist.bcCode" data-toggle="collapse" v-bind:data-target="'#t' + plist.bcCode" aria-expanded="true" style="width:80%; display: inline-block">
							        	{{plist.bcTitle}}({{plist.bdSum}})
							        </a>
							        <img src= "img/pencil-edit-button.png" v-bind:id="'pen' + plist.bcCode" class="dp_n1" v-on:click="updateShow(plist.bcCode,1)">
									<img src= "img/delete-button.png" v-bind:id="'del' + plist.bcCode" class="dp_n1" v-on:click="deleteCate(plist.bcCode, plist.bdSum)">	
						        </div>
						        <div class="input-group dp_n1" v-bind:id="'div' + plist.bcCode">
									<input type="text" class="form-control bg-light border-0 small" style="width:65%; display: inline-block" v-bind:placeholder="plist.bcTitle" v-model="updateTitle">
									<div class="input-group-append" style="display: inline">
										<button type="button" class="btn btn-primary" v-on:click="updateCate(plist.bcCode,1,plist.bcRating)">변경</button>
										<button type="button" class="btn btn-primary" v-on:click="cancelShow(plist.bcCode,1)">취소</button>
									</div>
									
									<table class="table mt-2">
										<tr>
				                			<td>카테고리 권한 :</td>
				                			<td>
				                				<input type="radio" v-model="plist.bcRating" value= 0 v-bind:id="'MallB'+plist.bcCode">
					                			<label :for="'MallB' +plist.bcCode">모두에게</label>
				                			</td>
				                			<td>
				                				<input type="radio" v-model="plist.bcRating" value= 10 v-bind:id="'MgenerB'+plist.bcCode">
					                			<label :for="'MgenerB'+plist.bcCode">일반회원</label>
				                			</td>
				                			<td>
				                				<input type="radio" v-model="plist.bcRating" value= 90 v-bind:id="'MadminB'+plist.bcCode">
					                			<label :for="'MadminB'+plist.bcCode">관리자</label>
				                			</td>
				                		</tr>
				                	</table>
									
								</div>
								
							    <div v-bind:id="'t' + plist.bcCode" class="collapse" data-parent="#aa">
									<div class="bg-white py-2 collapse-inner rounded">
										<div v-for="clist in plist.child">
											<div v-on:mouseover="showIcon(clist.bcCode,2)" v-on:mouseout="hideIcon(clist.bcCode,2)">
												<a href="#" class="collapse-item" style="width:80%; display: inline-block" v-bind:id="'clist' + clist.bcCode">{{clist.bcTitle}}({{clist.bdSum}})</a>
												<img src= "img/pencil-edit-button.png" v-bind:id="'cpen' + clist.bcCode" class="dp_n1" v-on:click="updateShow(clist.bcCode,2)">
												<img src= "img/delete-button.png" v-bind:id="'cdel' + clist.bcCode" class="dp_n1" v-on:click="deleteCate(clist.bcCode, clist.bdSum)">	
											</div>
											<div class="input-group dp_n1" v-bind:id="'cdiv' + clist.bcCode">
												<input type="text" class="form-control bg-light border-0 small" style="width:65%; display: inline-block" v-bind:placeholder="clist.bcTitle" v-model="updateTitle">
												<div class="input-group-append" style="display: inline">
													<button type="button" class="btn btn-primary" v-on:click="updateCate(clist.bcCode,2,clist.bcRating)">변경</button>
													<button type="button" class="btn btn-primary" v-on:click="cancelShow(clist.bcCode,2)">취소</button>
												</div>
												
												<table class="table mt-2">
													<tr>
				                						<td>카테고리 권한 :</td>
				                						<td>
				                							<input type="radio" v-model="clist.bcRating" value= 0 v-bind:id="'allB'+clist.bcCode">
					                						<label :for="'allB' +clist.bcCode">모두에게</label>
				                						</td>
				                						<td>
				                							<input type="radio" v-model="clist.bcRating" value= 10 v-bind:id="'generB'+clist.bcCode">
					                						<label :for="'generB'+clist.bcCode">일반회원</label>
				                						</td>
				                						<td>
				                							<input type="radio" v-model="clist.bcRating" value= 90 v-bind:id="'adminB'+clist.bcCode">
					                						<label :for="'adminB'+clist.bcCode">관리자</label>
				                						</td>
				                					</tr>
														
				                					<tr>
				                						<td>카테고리 종류 :</td>
				                						<td>
				                							<span v-if="clist.bcType ==1">텍스트 게시판</span>
				                							<span v-if="clist.bcType ==2">이미지 게시판</span>
				                							<span v-if="clist.bcType ==3">동영상 게시판</span>
				                						</td>
				                						<td></td>
				                						<td></td>
				                					</tr>
				                				</table>
				                				
											</div>
										</div>
										
										
										<div class="input-group dp_n1" v-bind:id="'ccf'+plist.bcCode">
											<input type="text" class="form-control bg-light border-0 small" placeholder="하위 카테고리명을 입력하세요." style="width:65%; display: inline-block" v-model="childTitle">
											<div class="input-group-append" style="display: inline">
												<button type="button" class="btn btn-primary" v-on:click="insertCate(plist.bcCode)">추가</button>
												<button type="button" class="btn btn-primary" v-on:click="formShow(2,plist.bcCode)">취소</button>
											</div>
											
			                				<table class="table mt-2">
												<tr>
			                						<td>카테고리 권한 :</td>
			                						<td>
			                							<input type="radio" v-model="bcRating" value= 0 v-bind:id="'allB'+plist.bcCode">
				                						<label :for="'allB'+plist.bcCode">모두에게</label>
			                						</td>
			                						<td>
			                							<input type="radio" v-model="bcRating" value= 10 v-bind:id="'generB'+plist.bcCode">
				                						<label :for="'generB'+plist.bcCode">일반회원</label>
			                						</td>
			                						<td>
			                							<input type="radio" v-model="bcRating" value= 90 v-bind:id="'adminB'+plist.bcCode">
				                						<label :for="'adminB'+plist.bcCode">관리자</label>
			                						</td>
			                					</tr>
		
			                					<tr>
			                						<td>카테고리 종류 :</td>
			                						<td>
			                							<input type="radio" v-model="bcType" value= 1 v-bind:id="'textB'+plist.bcCode">
				                						<label :for="'textB'+plist.bcCode">텍스트 게시판</label>
			                						</td>
			                						<td>
			                							<input type="radio" v-model="bcType" value= 2 v-bind:id="'imgB'+plist.bcCode">
				                						<label :for="'imgB'+plist.bcCode">이미지 게시판</label>
			                						</td>
			                						<td>
			                							<input type="radio" v-model="bcType" value= 3 v-bind:id="'mediaB'+plist.bcCode">
				                						<label :for="'mediaB'+plist.bcCode">동영상 게시판</label>
			                						</td>
			                					</tr>
			                				</table>
		                				
									    </div>
									    
										<a href="#" style="font-size:1rem" v-bind:id="'cC'+plist.bcCode" v-on:click="formShow(2,plist.bcCode)">+ 하위 카테고리 추가</a>
									
									</div>
							    </div>
						      </div>
						     
						      <div class="input-group dp_n1" id="pcf">
								<input type="text" class="form-control bg-light border-0 small" placeholder="메인 카테고리명을 입력하세요." style="width:65%; display: inline-block" v-model="bcTitle">
								<div class="input-group-append" style="display: inline">
									<button type="button" class="btn btn-primary" v-on:click="insertCate(0)">추가</button>
									<button type="button" class="btn btn-primary" v-on:click="formShow(1)">취소</button>
								</div>
								<table class="table mt-2">
									<tr>
			                			<td>카테고리 권한 :</td>
			                			<td>
			                				<input type="radio" v-model="bcRating" value= 0 id="allB">
				                			<label for="allB">모두에게</label>
			                			</td>
			                			<td>
			                				<input type="radio" v-model="bcRating" value= 10 id="generB">
				                			<label for="generB">일반회원</label>
			                			</td>
			                			<td>
			                				<input type="radio" v-model="bcRating" value= 90 id="adminB">
				                			<label for="adminB">관리자</label>
			                			</td>
			                		</tr>
								</table>
								
							  </div>
						      
						      <a href="#" v-on:click="formShow(1)" id="pC">+ 메인 카테고리 추가</a>
						      
						 </div>
		            </div>
		        </div>
          	</div>
          </div>

<jsp:include page="/WEB-INF/view/manage/script/cateManageScript.jsp"></jsp:include>
    