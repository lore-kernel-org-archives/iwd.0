Received: from mail-108-mta177.mxroute.com (mail-108-mta177.mxroute.com [136.175.108.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C33A1875
	for <iwd@lists.linux.dev>; Wed, 22 Jun 2022 19:47:44 +0000 (UTC)
Received: from filter006.mxroute.com ([140.82.40.27] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta177.mxroute.com (ZoneMTA) with ESMTPSA id 1818cf0075400028a7.001
 for <iwd@lists.linux.dev>
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Wed, 22 Jun 2022 19:42:29 +0000
X-Zone-Loop: 82670c8145e72cb279c6061741dcd8ef552df3bd5e79
X-Originating-IP: [140.82.40.27]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=twosheds.org; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mUr4WYYi0VCIWTHh67WAJSA+LRuqrc6uSgxwwxCzG/w=; b=U3evE1VGc/XNd63F0/XzkXvekm
	cTp+Mk2/Dx1J2FqF7zcg9/P6lW8qdzXLfmrAvO3KxuAyXdTDOV746RAdp9bDprSaDqWZoNqmYVjzX
	VTER6Gh4EIsH3dOJv0QxtSiHYMiu7iSr/LCrVRUIFcR0yKAIYdc6tgj8SuCQL5fi5Fx7GvFowtz73
	Swaf9dDVv1or1OPNH3jiW0NG7OXAViQ1L6fEqhRE/7l3Nt34GkZIvinasn/73Opfg9WU54DFv6iVw
	r9TOh9yDaPkjMwfUui7XcGfIwawWbde1zjhqEwi0BG5ge1XlERqaghXlOkg+qM5mFDtBziVwJOz2j
	Ow/vZ1PQ==;
From: Jesse Lentz <jesse@twosheds.org>
To: iwd@lists.linux.dev
Cc: Jesse Lentz <jesse@twosheds.org>
Subject: [PATCH 2/2] doc: Add State and Role properties to DPP API
Date: Wed, 22 Jun 2022 15:41:42 -0400
Message-Id: <20220622194142.213135-2-jesse@twosheds.org>
In-Reply-To: <20220622194142.213135-1-jesse@twosheds.org>
References: <20220622194142.213135-1-jesse@twosheds.org>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: jesse@twosheds.org

Document the State and Role properties of the DeviceProvisioning API.
---
 doc/device-provisioning-api.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/doc/device-provisioning-api.txt b/doc/device-provisioning-api.txt
index 0aba2557..c1d706ec 100644
--- a/doc/device-provisioning-api.txt
+++ b/doc/device-provisioning-api.txt
@@ -56,3 +56,13 @@ Methods		string StartEnrollee()
 						net.connman.iwd.NotConfigured
 						net.connman.iwd.NotSupported
 						net.connman.iwd.Busy
+
+Properties	string State [readonly, optional]
+
+			Reflects the DPP state. Possible values are "presence",
+			"authenticating", and "configuring".
+
+		string Role [readonly, optional]
+
+			Reflects the DPP role. Possible values are "enrollee"
+			and "configurator"
-- 
2.36.1

