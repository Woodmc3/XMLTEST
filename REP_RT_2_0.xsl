<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
	<xsl:param name="labelFile" select="'https://rawgit.com/HC-IMSD/REP/dan_tempDossierSumm/xslt/hp-ip400-labels.xml'"/>
	<xsl:param name="language" select="'eng'"/>
	<xsl:variable name="labelLookup" select="document($labelFile)"/>
	<xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'"/>
	<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
	<xsl:template match="/">

		<html>
			<head>
				<link href="https://lam-dev.hres.ca/rep-dev/GCWeb/css/theme.min.css" type="text/css" rel="stylesheet" />
				<link href="https://lam-dev.hres.ca/rep-dev/dossier/app/styles/rep.css" type="text/css" rel="stylesheet" />
				<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" type="text/css" rel="stylesheet" />
				<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js" type="text/javascript" charset="utf-8"></script>
				<script type="text/javascript">
					function addSelectBox(){
						$("span").each(function(item){
							$(this).mouseenter(function(){$(this).css("border", "1px solid black")}).mouseleave(function(){$(this).css("border", "0px")});
						});
					}
					function showDetail(e){
						var next = $(e).next();
						if(next.is(":visible")){
							var child =$(e).find(".fa-caret-down");
							child.removeClass('fa-caret-down');
							child.addClass('fa-caret-right');
							next.removeClass('active');
							next.addClass('out');
						} else {
							var child =$(e).find(".fa-caret-right");
							child.removeClass('fa-caret-right');
							child.addClass('fa-caret-down');
							next.removeClass('out');
							next.addClass('active');
						}
					}
				</script>
			</head>
            <body onload="addSelectBox();">
				<xsl:if test="count(TRANSACTION_ENROL) &gt; 0"> <xsl:apply-templates select="TRANSACTION_ENROL"></xsl:apply-templates> </xsl:if>
			</body>
		</html>
	</xsl:template>
	
	<!-- Transaction Enrolment -->
	<xsl:template match="TRANSACTION_ENROL">
		<h1>Regulatory Transaction Template: Regulatory Enrolment Process (REP)</h1>
					<div class="well well-sm" >
						<TABLE border="1" cellspacing="2" cellpadding="2" style="table-layout: fixed; width: 100%;word-wrap: break-word;">
							<TR>
								<TD style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'COMPANY_ID'"/></xsl:call-template></TD>
								<TD style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DOSSIER_TYPE'"/></xsl:call-template></TD>
								<TD style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DossierID'"/></xsl:call-template></TD>
								<TD style="text-align: center;font-weight:bold;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DateLastSaved'"/></xsl:call-template></TD>
							</TR>
							<TR>
								<TD style="text-align: center;"> <xsl:apply-templates select="ectd/company_id" /> </TD>
								<TD style="text-align: center;"> <xsl:call-template name="hp-label"><xsl:with-param name="code"><xsl:apply-templates select="ectd/dossier_type" /></xsl:with-param></xsl:call-template> </TD>
								<TD style="text-align: center;"> <xsl:apply-templates select="ectd/dossier_id" /> </TD>
								<TD style="text-align: center;"> <xsl:apply-templates select="date_saved" /> </TD>
							</TR>
						</TABLE>
					</div>
		<section>
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h2 class="panel-title">Transaction Information</h2>
				</div>
				<div class="panel-body">										
					<div class="well well-sm" >
						<div class="row">
							<div class="col-xs-12">
								<label> <xsl:call-template name="hp-label"><xsl:with-param name="code" select="'PRODUCT_NAME'"/></xsl:call-template>&#160; </label>
								<span class="transaction_enrol">
									<xsl:value-of select="ectd/product_name"/>
								</span>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-12">
								<label> <xsl:call-template name="hp-label"><xsl:with-param name="code" select="'TRANSACTION_TYPE'"/></xsl:call-template>&#160; </label>
								<span class="transaction_enrol">
									<xsl:choose>
									<xsl:when test=" translate(./transaction_type, $smallcase, $uppercase) = 'NEW'">
										<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'NEW'"/></xsl:call-template>
										<div class="row">
											<div class="col-xs-12">
												<label> <xsl:call-template name="hp-label"><xsl:with-param name="code" select="'IS_THIRD_PARTY'"/></xsl:call-template>&#160; </label>
												<span class="transaction_enrol"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="is_third_party"/></xsl:call-template>
												</span>
											</div>
											<xsl:if test="is_third_party = 'Y'">
											<div class="col-xs-11 alert alert-info">
												<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'IS_THIRD_PARTY_INFO'"/></xsl:call-template>
											</div>
											</xsl:if>
										</div>
										<div class="row">
											<div class="col-xs-12">
												<label> <xsl:call-template name="hp-label"><xsl:with-param name="code" select="'IS_PRIORITY'"/></xsl:call-template>&#160; </label>
												<span class="transaction_enrol"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="is_priority"/></xsl:call-template>
												</span>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-12">
												<label> <xsl:call-template name="hp-label"><xsl:with-param name="code" select="'IS_NOC'"/></xsl:call-template>&#160; </label>
												<span class="transaction_enrol"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="is_noc"/></xsl:call-template>
												</span>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-12">
												<label> <xsl:call-template name="hp-label"><xsl:with-param name="code" select="'IS_ADMIN_SUB'"/></xsl:call-template>&#160; </label>
												<span class="transaction_enrol"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="is_admin_sub"/></xsl:call-template>
												</span>
											</div>
										</div>
										<xsl:if test="is_admin_sub = 'Y'">
										<div class="row">
											<div class="col-xs-12">
												<label> <xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ADMIN_SUB_TYPE'"/></xsl:call-template>&#160; </label>
												<span class="transaction_enrol">
													<xsl:choose>
														<xsl:when test="$language = 'eng'"><xsl:value-of select="sub_type/en"/></xsl:when>
														<xsl:otherwise><xsl:value-of select="sub_type/fr"/></xsl:otherwise>
													</xsl:choose>
												</span>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-12">
												<label> <xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ADMIN_SUB_TYPE_DESC'"/></xsl:call-template>&#160; </label>
												<ul><li><xsl:call-template name="hp-label"><xsl:with-param name="code"><xsl:value-of select="concat(sub_type/id,'_li')"/></xsl:with-param></xsl:call-template></li></ul>
											</div>
										</div>
										<div class="row alert alert-info col-xs-12">
											<span><xsl:call-template name="hp-label"><xsl:with-param name="code"><xsl:value-of select="concat(sub_type/id, '_note')" disable-output-escaping="yes"/></xsl:with-param></xsl:call-template>
											</span>
										</div>
										</xsl:if>
									</xsl:when>
									<xsl:otherwise>
										<xsl:call-template name="hp-label">
											<xsl:with-param name="code" select="'EXSITING'"/>
											
										</xsl:call-template>
									</xsl:otherwise>
									</xsl:choose>
								</span>
							</div>
						</div>
					</div>

					<div class="well well-sm" >
							<div class="row">
								<header class="panel-heading" >
									<h4 class="panel-title" ><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'LIFECYCLE_TITLE'"/></xsl:call-template></h4>
								</header>								
								
								<div class="panel-body" >
									<TABLE border="1" cellspacing="2" cellpadding="2" style="table-layout: fixed; width: 100%;word-wrap: break-word;">
										<TR>
											<td style="width:2%"></td>
											<TD style="text-align: center;" width="10%"> <label> <xsl:call-template name="hp-label"><xsl:with-param name="code" select="'SEQUENCE_NUM'"/></xsl:call-template> </label> </TD>
											<TD style="text-align: center;" width="10%"> <label> <xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DATE_SUBMITTED'"/></xsl:call-template> </label> </TD>
											<TD style="text-align: center;" width="10%"> <label> <xsl:call-template name="hp-label"><xsl:with-param name="code" select="'CONTROL_NUM'"/></xsl:call-template> </label> </TD>
											<TD style="text-align: center;" width="30%"> <label> <xsl:call-template name="hp-label"><xsl:with-param name="code" select="'REG_ACTIVITY'"/></xsl:call-template> </label> </TD>
											<TD style="text-align: center;" width="40%"> <label> <xsl:call-template name="hp-label"><xsl:with-param name="code" select="'SEQUENCE_DESCRIPT'"/></xsl:call-template> </label> </TD>
										</TR>
										
										<xsl:for-each select="ectd/lifecycle_record">
											<TR  onclick="showDetail(this);">
											<td class="fa fa-caret-right fa-lg fa-fw"></td>
											<TD style="text-align: center;"><span> <xsl:apply-templates select="sequence_number" /></span> </TD>
											<TD style="text-align: center;"><span> <xsl:apply-templates select="date_submitted" /></span> </TD>
											<TD ><span> <xsl:apply-templates select="control_number" /></span> </TD>
											<TD> <span>
												<xsl:call-template name="hp-label">
													<xsl:with-param name="code" select="sequence_activity_type"/>
													
												</xsl:call-template></span>
											</TD>
											<TD><span><xsl:apply-templates select="sequence_concat" /></span> </TD>
											</TR>
											<tr class="out">
												<td colspan="6"> 
													<fieldset>
														<legend><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'LIFECYCLE_RECORD'"/></xsl:call-template></legend>
														<div class="row">
															<div class="form-group col-md-4">
															<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'SEQUENCE_NUM'"/></xsl:call-template>:&#160;<span style="font-weight: normal;"><xsl:value-of select="sequence_number"/></span></label>
															</div>
															<div class="form-group col-md-4">
															<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DATE_SUBMITTED'"/></xsl:call-template>:&#160;<span style="font-weight: normal;"><xsl:value-of select="./date_filed"/></span></label>
															</div>
															<div class="form-group col-md-4">
															<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'CONTROL_NUM'"/></xsl:call-template>:&#160;<span style="font-weight: normal;"><xsl:value-of select="control_number"/></span></label>
															</div>
														</div>
														<div class="row">
															<div class="form-group col-md-12">
															<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'REG_ACTIVITY_LEAD'"/></xsl:call-template>:&#160;<span style="font-weight: normal;"><xsl:call-template name="hp-label"><xsl:with-param name="code"><xsl:value-of select="./sequence_activity_lead"/></xsl:with-param></xsl:call-template></span></label>
															</div>
														</div>
														<div class="row">
															<div class="form-group col-md-6">
															<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ACTIVITY_TYPE'"/></xsl:call-template>:&#160;<span style="font-weight: normal;"><xsl:call-template name="hp-label"><xsl:with-param name="code"><xsl:value-of select="./sequence_activity_type"/></xsl:with-param></xsl:call-template></span></label>
															</div>
															<div class="form-group col-md-6">
															<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'REG_TRANSACTION_DESC'"/></xsl:call-template>:&#160;<span style="font-weight: normal;"><xsl:call-template name="hp-label"><xsl:with-param name="code"><xsl:value-of select="./sequence_description_value"/></xsl:with-param></xsl:call-template></span></label>
															</div>
														</div>
														<div class="row">
															<xsl:choose>
															<xsl:when test="./sequence_description_value = 'UNSOLICITED_DATA'">
															<div class="form-group col-md-12">
																<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'BRIEF_DESC'"/></xsl:call-template>:&#160;</label>
																<span style="font-weight: normal;"><xsl:value-of select="./sequence_details"/></span>
															</div>
															</xsl:when>
															<xsl:otherwise>
															<div class="form-group col-md-6">
																<xsl:if test="./sequence_from_date != ''">
																	<xsl:choose>
																	<xsl:when test="./sequence_to_date = ''">
																		<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DATED'"/></xsl:call-template>:&#160;<span style="font-weight: normal;"><xsl:value-of select="./sequence_from_date"/></span></label>
																	</xsl:when>
																	<xsl:otherwise>
																		<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'START_DATE'"/></xsl:call-template>:&#160;<span style="font-weight: normal;"><xsl:value-of select="./sequence_from_date"/></span></label>
																	</xsl:otherwise>
																	</xsl:choose>
																</xsl:if>
																<xsl:if test="./sequence_year != ''">
																	<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'YEAR_OF_CHANGE'"/></xsl:call-template>:&#160;<span style="font-weight: normal;"><xsl:value-of select="./sequence_year"/></span></label>
																</xsl:if>
															</div>
															<div class="form-group col-md-6">
																<xsl:if test="./sequence_to_date != ''">
																	<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'END_DATE'"/></xsl:call-template>:&#160;<span style="font-weight: normal;"><xsl:value-of select="./sequence_to_date"/></span></label>
																</xsl:if>
																<xsl:if test="./sequence_version != ''">
																	<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'VERSION_NO'"/></xsl:call-template>:&#160;<span style="font-weight: normal;"><xsl:value-of select="./sequence_version"/></span></label>
																</xsl:if>
															</div>
															</xsl:otherwise>
															</xsl:choose>
															<xsl:if test="./sequence_year != ''">
															<div class="form-group col-md-12">
																<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'LIST_DESC'"/></xsl:call-template>:&#160;</label>
																<span style="font-weight: normal;"><xsl:value-of select="./sequence_details"/></span>
															</div>
															</xsl:if>
														</div>
													</fieldset>
												</td>
											</tr>
										</xsl:for-each>
									</TABLE>
								</div>
							</div>
						</div>
						

					<div class="well well-sm" >
						<div class="row">
							<div class="col-xs-12">
								<label> <xsl:call-template name="hp-label"><xsl:with-param name="code" select="'IS_SOLICITED'"/></xsl:call-template>&#160; </label>
								<span class="transaction_enrol"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="is_solicited"/></xsl:call-template>
								</span>
							</div>
						</div>
						<xsl:if test="is_solicited = 'Y'">
							<div class="row">
								<div class="col-xs-12">
									<label> <xsl:call-template name="hp-label"><xsl:with-param name="code" select="'SOLICITED_RQ'"/></xsl:call-template>:&#160; </label>
									<span class="transaction_enrol"> <xsl:apply-templates select="solicited_requester" /> </span>
									<ol>
										<xsl:for-each select="solicited_requester_record">
											<li><span><xsl:value-of select="./solicited_requester"/></span></li>
										</xsl:for-each>
									</ol>
								</div>
							</div>
						</xsl:if>
					</div>
					
					<h4><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'PROJ_MANAGER_NAME'"/></xsl:call-template>: </h4>
					
					<div class="well well-sm" >
						<div class="row">
							<div class="col-xs-12">
								<span class="transaction_enrol"> <xsl:apply-templates select="regulatory_project_manager1" /> </span>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-12">
								<span class="transaction_enrol"> <xsl:apply-templates select="regulatory_project_manager2" /> </span>
							</div>
						</div>
					</div>
					<div class="well well-sm" >
						<div class="row">
							<div class="col-xs-12">
								<label> <xsl:call-template name="hp-label"><xsl:with-param name="code" select="'IS_FEE_TRANSACTION'"/></xsl:call-template>&#160; </label>
								<span class="transaction_enrol"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="is_fees"/></xsl:call-template>
								</span>
							</div>
						</div>
					</div>

				</div>		
			</div>
			<xsl:if test="is_fees = 'Y'">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h2 class="panel-title"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'FEE_AMOUNT'"/></xsl:call-template></h2>
				</div>
				<div class="panel-body">
					<div class="well well-sm" >
						<div class="row">
							<div class="col-xs-12">
								<label> <xsl:call-template name="hp-label"><xsl:with-param name="code" select="'SUB_CLASS'"/></xsl:call-template>:&#160; </label>
								<span class="transaction_enrol">
								<xsl:choose>
								<xsl:when test="$language = 'fra'">
									<xsl:value-of select="fee_details/submission_class/fr"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="fee_details/submission_class/en"/>
								</xsl:otherwise>
								</xsl:choose>
								</span>
								<label>&#160;&#160;<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'FEE_AMOUNT'"/></xsl:call-template>:&#160;</label>
								<span>$<xsl:value-of select="fee_details/submission_class/fee"/></span>
							</div>
							<div class="col-xs-12">
								<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'FEE_DESCRIPTION'"/></xsl:call-template>:&#160;</label>
								<span>
								<xsl:choose>
								<xsl:when test="$language = 'fra'">
									<xsl:value-of select="fee_details/submission_class/description_fr"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="fee_details/submission_class/description_en"/>
								</xsl:otherwise>
								</xsl:choose>
								</span>
							</div>
						</div>
					</div>
					<div class="well well-sm" >
						<div class="row">
							<div class="col-xs-12">
								<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DEFER_FEES'"/></xsl:call-template>?&#160; </label>
								<span class="transaction_enrol"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="fee_details/deferral_request"/></xsl:call-template>
								</span>
							</div>
							<div class="col-xs-12">
								<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'FEE_REMISSION'"/></xsl:call-template>?&#160; </label>
								<span class="transaction_enrol"><xsl:call-template name="YesNoUnknow"><xsl:with-param name="value" select="fee_details/fee_remission"/></xsl:call-template>
								</span>
							</div>
							<xsl:if test="fee_details/fee_remission = 'Y'">
							<div class="col-xs-12">
								<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'GROSS_REVENUE'"/></xsl:call-template>:&#160; </label>
								<span class="transaction_enrol">$<xsl:value-of select="fee_details/gross_revenue"/></span>
								<label> &#160;&#160;<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'TEN_PERCENT_REVENUE'"/></xsl:call-template>:&#160; </label>
								<span class="transaction_enrol">$<xsl:value-of select="fee_details/percent_gross"/></span>
							</div>
							<div class="col-xs-12 alert alert-success">
								<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'NOTE_1'"/></xsl:call-template>
							</div>
							</xsl:if>
						</div>
					</div>
					<xsl:if test="fee_details/deferral_request = 'Y' or fee_details/fee_remission = 'Y'">
					<h4><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'REQUIRED_DOC'"/></xsl:call-template></h4>
					<div class="well well-sm" >
						<xsl:if test="fee_details/deferral_request = 'Y'">
						<div class="row">
							<div class="col-xs-12">
					            <xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:if test=" fee_details/required_docs/deferral_statement = 'Y'">
                                        <xsl:attribute name="checked"></xsl:attribute>
                                    </xsl:if>
                                    <xsl:attribute name="disabled">disabled</xsl:attribute>
									<xsl:attribute name="style">float:left;width:25px;</xsl:attribute>
                                </xsl:element>
								<span style="display:block;float:left;width:95%;">
									<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'DEFER_STATEMENT'"/></xsl:call-template>
								</span>
							</div>
						</div>
						</xsl:if>
						<xsl:if test="fee_details/fee_remission = 'Y' and fee_details/submission_class/fee &gt; fee_details/percent_gross">
						<div class="row">
							<div class="col-xs-12">
								<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'NOTE_2'"/></xsl:call-template></label>
							</div>
							<div class="col-xs-12">
					            <xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:if test=" fee_details/required_docs/remission_certified = 'Y'">
                                        <xsl:attribute name="checked"></xsl:attribute>
                                    </xsl:if>
                                    <xsl:attribute name="disabled">disabled</xsl:attribute>
									<xsl:attribute name="style">float:left;width:25px;</xsl:attribute>
                                </xsl:element>
								<span style="display:block;float:left;width:95%;">
									<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'STATEMENT_REVENUE'"/></xsl:call-template>
								</span>
							</div>
							<div class="col-xs-12">
					            <xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:if test=" fee_details/required_docs/est_market_share = 'Y'">
                                        <xsl:attribute name="checked"></xsl:attribute>
                                    </xsl:if>
                                    <xsl:attribute name="disabled">disabled</xsl:attribute>
									<xsl:attribute name="style">width:25px;</xsl:attribute>
                                </xsl:element>
								<span class="transaction_enrol">
									<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'EST_MARKET_SHARE'"/></xsl:call-template>
								</span>
							</div>
							<div class="col-xs-12">
					            <xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:if test=" fee_details/required_docs/comparison_products = 'Y'">
                                        <xsl:attribute name="checked"></xsl:attribute>
                                    </xsl:if>
                                    <xsl:attribute name="disabled">disabled</xsl:attribute>
									<xsl:attribute name="style">width:25px;</xsl:attribute>
                                </xsl:element>
								<span class="transaction_enrol">
									<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'SIMILAR_PRODUCT'"/></xsl:call-template>
								</span>
							</div>
							<div class="col-xs-12">
					            <xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:if test=" fee_details/required_docs/sales_history = 'Y'">
                                        <xsl:attribute name="checked"></xsl:attribute>
                                    </xsl:if>
                                    <xsl:attribute name="disabled">disabled</xsl:attribute>
									<xsl:attribute name="style">width:25px;</xsl:attribute>
                                </xsl:element>
								<span class="transaction_enrol">
									<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'SALES_HISTORY'"/></xsl:call-template>
								</span>
					            &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;<xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:if test=" fee_details/required_docs/market_plan = 'Y'">
                                        <xsl:attribute name="checked"></xsl:attribute>
                                    </xsl:if>
                                    <xsl:attribute name="disabled">disabled</xsl:attribute>
                                </xsl:element>&#160;
								<span class="transaction_enrol">
									<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'MARKETING_PLAN'"/></xsl:call-template>
								</span>
							</div>
							<div class="col-xs-12">
					            <xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:if test=" fee_details/required_docs/avg_sale_price = 'Y'">
                                        <xsl:attribute name="checked"></xsl:attribute>
                                    </xsl:if>
                                    <xsl:attribute name="disabled">disabled</xsl:attribute>
									<xsl:attribute name="style">width:25px;</xsl:attribute>
                                </xsl:element>
								<span class="transaction_enrol">
									<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'AVG_SALES'"/></xsl:call-template>
								</span>
					            &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;<xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:if test=" fee_details/required_docs/other = 'Y'">
                                        <xsl:attribute name="checked"></xsl:attribute>
                                    </xsl:if>
                                    <xsl:attribute name="disabled">disabled</xsl:attribute>
                                </xsl:element>&#160;
								<span class="transaction_enrol">
									<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'OTHER'"/></xsl:call-template>
								</span>
							</div>
							<xsl:if test="fee_details/required_docs/other = 'Y'">
							<div class="col-xs-12">
								<label>&#160;&#160;&#160;&#160;&#160;<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'OTHER'"/></xsl:call-template>:&#160;</label>
								<span><xsl:value-of select="fee_details/required_docs/other_details"/></span>
							</div>
							</xsl:if>
						</div>
						</xsl:if>
					</div>
					</xsl:if>

					<h3><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'PAYMENT'"/></xsl:call-template></h3>
					<div class="well well-sm" >
						<div class="row">
							<div class="col-xs-12 form-group alert alert-info">
							<xsl:choose>
							<xsl:when test="fee_details/fee_remission = 'N' and fee_details/deferral_request = 'N' and fee_details/submission_class/fee &gt; 10000">
								<p><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'NOTE_6'"/></xsl:call-template></p>
							</xsl:when>
							<xsl:when test="fee_details/fee_remission = 'N' and fee_details/deferral_request = 'Y' and fee_details/submission_class/fee &lt; 10000">
								<p><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'NOTE_4'"/></xsl:call-template></p>
							</xsl:when>
							<xsl:otherwise>
								<p><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'NOTE_3'"/></xsl:call-template></p>
							</xsl:otherwise>
							</xsl:choose>
							</div>
							<xsl:if test="fee_details/submission_class/fee &lt; 10000 and (fee_details/deferral_request = 'N' or fee_details/fee_remission = 'Y')">
							<div class="col-xs-12">
								<h4><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'PAYMENT_METHODS'"/></xsl:call-template></h4>
							</div>
							<div class="col-xs-12">
					            <label><xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:if test=" fee_details/payment_method/bill_payment = 'Y'">
                                        <xsl:attribute name="checked"></xsl:attribute>
                                    </xsl:if>
                                    <xsl:attribute name="disabled">disabled</xsl:attribute>
									<xsl:attribute name="style">float:left;width:25px;</xsl:attribute>
                                </xsl:element>
								<span style="font-weight:normal;">
									<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'PREFEERED_OPTION'"/></xsl:call-template>
								</span>&#160;&#160;</label>
					            <label><xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:if test=" fee_details/payment_method/existing_credit = 'Y'">
                                        <xsl:attribute name="checked"></xsl:attribute>
                                    </xsl:if>
                                    <xsl:attribute name="disabled">disabled</xsl:attribute>
									<xsl:attribute name="style">float:left;width:25px;</xsl:attribute>
                                </xsl:element>
								<span style="font-weight:normal;">
									<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'EXISTING_CREDIT'"/></xsl:call-template>
								</span>&#160;&#160;</label>
					            <label><xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:if test=" fee_details/payment_method/bank_wire = 'Y'">
                                        <xsl:attribute name="checked"></xsl:attribute>
                                    </xsl:if>
                                    <xsl:attribute name="disabled">disabled</xsl:attribute>
									<xsl:attribute name="style">float:left;width:25px;</xsl:attribute>
                                </xsl:element>
								<span style="font-weight:normal;">
									<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'BANK_WIRE'"/></xsl:call-template>
								</span></label>
							</div>
							<div class="col-xs-12">
					            <label><xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:if test=" fee_details/payment_method/credit_card = 'Y'">
                                        <xsl:attribute name="checked"></xsl:attribute>
                                    </xsl:if>
                                    <xsl:attribute name="disabled">disabled</xsl:attribute>
									<xsl:attribute name="style">float:left;width:25px;</xsl:attribute>
                                </xsl:element>
								<span style="font-weight:normal;">
									<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'CREDIT'"/></xsl:call-template>
								</span>&#160;&#160;</label>
					            <label><xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:if test=" fee_details/payment_method/cheque = 'Y'">
                                        <xsl:attribute name="checked"></xsl:attribute>
                                    </xsl:if>
                                    <xsl:attribute name="disabled">disabled</xsl:attribute>
									<xsl:attribute name="style">float:left;width:25px;</xsl:attribute>
                                </xsl:element>
								<span style="font-weight:normal;">
									<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'CHEQUE'"/></xsl:call-template>
								</span>&#160;&#160;</label>
					            <label><xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:if test=" fee_details/payment_method/money_order = 'Y'">
                                        <xsl:attribute name="checked"></xsl:attribute>
                                    </xsl:if>
                                    <xsl:attribute name="disabled">disabled</xsl:attribute>
									<xsl:attribute name="style">float:left;width:25px;</xsl:attribute>
                                </xsl:element>
								<span style="font-weight:normal;">
									<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'MONEY_ORDER'"/></xsl:call-template>
								</span>&#160;&#160;</label>
					            <label><xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:if test=" fee_details/payment_method/bank_draft = 'Y'">
                                        <xsl:attribute name="checked"></xsl:attribute>
                                    </xsl:if>
                                    <xsl:attribute name="disabled">disabled</xsl:attribute>
									<xsl:attribute name="style">float:left;width:25px;</xsl:attribute>
                                </xsl:element>
								<span style="font-weight:normal;">
									<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'BANK_DRAFT'"/></xsl:call-template>
								</span></label>
							</div>
							</xsl:if>
						</div>
					</div>

				</div>
			</div>
			</xsl:if>
			
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h2 class="panel-title"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'REG_ACT_CONTACT'"/></xsl:call-template></h2>
				</div>
				<div class="panel-body">
					<h4><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'REG_CONTACT_THIS'"/></xsl:call-template></h4>
					<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'COMPANY_INFO'"/></xsl:call-template>: </label>
					<div class="well well-sm" >
						<div class="row">
							<div class="col-xs-12">
								<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'COMPANY_NOABBREV'"/></xsl:call-template></label>
							</div>
							<div class="col-xs-12">
								<span class="transaction_enrol"><xsl:apply-templates select="company_name" /> </span>
							</div>
						</div>
					</div>
					<label><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'ADDRESS_INFO'"/></xsl:call-template>: </label>
					<div class="well well-sm" >
						<div class="row">
							<div class="col-xs-12">
								<label class="col-xs-2"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'STREET_SUITE'"/></xsl:call-template></label>
								<span class="transaction_enrol"> <xsl:apply-templates select="regulatory_activity_address/street_address" /> </span>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-12">
								<label class="col-xs-2"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'CITY_TOWN'"/></xsl:call-template> </label>
								<span class="transaction_enrol"> <xsl:apply-templates select="regulatory_activity_address/city" /> </span>
								<label> &#160;&#160;<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'PROVINCE'"/></xsl:call-template>&#160;&#160; </label>
								<span class="transaction_enrol"> <xsl:choose><xsl:when test="(regulatory_activity_address/country = 'CAN') or (regulatory_activity_address/country = 'USA')"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="regulatory_activity_address/province_lov" /></xsl:call-template></xsl:when><xsl:otherwise><xsl:apply-templates select="regulatory_activity_address/province_text" /></xsl:otherwise></xsl:choose> </span>
								<label> &#160;&#160;<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'COUNTRY'"/></xsl:call-template>&#160;&#160; </label>
								<span class="transaction_enrol"> 
								<xsl:choose>
								<xsl:when test="$language = 'fra'">
									<xsl:value-of select="regulatory_activity_address/country/@label_fr"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="regulatory_activity_address/country/@label_en"/>
								</xsl:otherwise>
								</xsl:choose>
								</span>
							</div>
							<div class="col-xs-12">
								<label class="col-xs-2"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'POSTAL_ZIP'"/></xsl:call-template> </label>
								<span class="transaction_enrol"> <xsl:apply-templates select="regulatory_activity_address/postal_code" /> </span>
							</div>
						</div>
					</div>
					<h4><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'COMPANY_REP_THIS'"/></xsl:call-template>: </h4>
					<div class="well well-sm" >
						<div class="row">
							<div class="col-xs-12">
								<label class="col-xs-3"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'SALUTATION'"/></xsl:call-template>&#160;&#160;
								<span class="transaction_enrol" style="font-weight:normal;"> <xsl:call-template name="hp-label"><xsl:with-param name="code" select="regulatory_activity_contact/salutation" /></xsl:call-template> </span></label>
								<label class="col-xs-3"> &#160;&#160;<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'JOBTITLE'"/></xsl:call-template>&#160;&#160; 
								<span class="transaction_enrol" style="font-weight:normal;"> <xsl:apply-templates select="regulatory_activity_contact/job_title" /> </span></label>
								<label class="col-xs-3"> &#160;&#160;<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'LANGCORRESPOND'"/></xsl:call-template>&#160;&#160; 
								<span class="transaction_enrol" style="font-weight:normal;"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="regulatory_activity_contact/language_correspondance"/></xsl:call-template></span></label>
							</div>
							<div class="col-xs-12">
								<label class="col-xs-3"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'FIRSTNAME'"/></xsl:call-template>&#160;&#160;
								<span class="transaction_enrol" style="font-weight:normal;"> <xsl:apply-templates select="regulatory_activity_contact/given_name" /> </span> </label>
								<label class="col-xs-3"> &#160;&#160;<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'INITIALS'"/></xsl:call-template>&#160;&#160;
								<span class="transaction_enrol" style="font-weight:normal;"> <xsl:apply-templates select="regulatory_activity_contact/initials" /> </span> </label>
								<label class="col-xs-3"> &#160;&#160;<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'LASTNAME'"/></xsl:call-template>&#160;&#160;
								<span class="transaction_enrol" style="font-weight:normal;"> <xsl:apply-templates select="regulatory_activity_contact/surname" /> </span> </label>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-12">
								<label class="col-xs-6"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'PHONENUMBER'"/></xsl:call-template>&#160;&#160;
								<span class="transaction_enrol" style="font-weight:normal;"> <xsl:apply-templates select="regulatory_activity_contact/phone_num" /> </span>&#160;&#160;
								<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'EXTENSION'"/></xsl:call-template> &#160;&#160;
								<span class="transaction_enrol" style="font-weight:normal;"> <xsl:apply-templates select="regulatory_activity_contact/phone_ext" /> </span> </label>
								<label class="col-xs-3">&#160;&#160;<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'FAX_NUMBER'"/></xsl:call-template>&#160;&#160; 
								<span class="transaction_enrol" style="font-weight:normal;"> <xsl:apply-templates select="regulatory_activity_contact/fax_num" /> </span></label>
							</div>
							<div class="col-xs-12">
								<label class="col-xs-2"><xsl:call-template name="hp-label"><xsl:with-param name="code" select="'CONTACTEMAIL'"/></xsl:call-template>&#160;&#160;
								<span class="transaction_enrol" style="font-weight:normal;"> <xsl:apply-templates select="regulatory_activity_contact/email" /> </span></label>
							</div>
						</div>
					</div>
					<div class="well well-sm" >
						<div class="row">
							<div class="col-xs-12">
								<label><xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:if test=" confirm_regulatory_contact = 'Y'">
                                        <xsl:attribute name="checked"></xsl:attribute>
                                    </xsl:if>
                                    <xsl:attribute name="disabled">disabled</xsl:attribute>
									<xsl:attribute name="style">float:left;width:25px;</xsl:attribute>
                                </xsl:element>
								<span>
									<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'CONFIRM_REGULATORY'"/></xsl:call-template>
								</span></label>
							</div>
						</div>
					</div>
					
				</div>		
			</div>
		</section>
	</xsl:template>
	<xsl:template name="hp-label">
		<xsl:param name="code" select="/.."/>
		<xsl:variable name="value" select="$labelLookup/SimpleCodeList/row[code=$code]/*[name()=$language]"/>
		<xsl:if test="$value">
			<xsl:for-each select="$labelLookup/SimpleCodeList/row[code=$code]/*[name()=$language]"><xsl:if test="position() > 1"><xsl:text disable-output-escaping="yes">&lt;br/&gt;</xsl:text></xsl:if><xsl:value-of select="."/></xsl:for-each>
		</xsl:if>
		<xsl:if test="not($value)">Error: code missing:(<xsl:value-of select="$code"/> in <xsl:value-of select="$labelFile"/>)</xsl:if>
	</xsl:template>
	<xsl:template name="YesNoUnknow">
		<xsl:param name="value" select="/.."/>
		<xsl:choose>
		<xsl:when test="$value = 'Y'">
			<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'Yes'"/></xsl:call-template>
		</xsl:when>
		<xsl:when test="$value = 'N'">
			<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'No'"/></xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="hp-label"><xsl:with-param name="code" select="'UNKNOWN'"/></xsl:call-template>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="yes" url="file:///e:/hcreprt-2018-08-22-1125.xml" htmlbaseurl="" outputurl="..\..\..\..\..\..\..\..\SPM\test\transaction.html" processortype="saxon8" useresolver="yes"
		          profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext=""
		          validateoutput="no" validator="internal" customvalidator="">
			<parameterValue name="labelFile" value="'file:///C:/Users/hcuser/git/HC-IMSD/REP/xslt/hp-ip400-labels.xml'"/>
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="schemaCache" value="||"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bSchemaAware" value="true"/>
			<advancedProp name="bGenerateByteCode" value="true"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
		</scenario>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->
