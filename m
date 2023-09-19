Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296FE30F8A
	for <iwd@lists.linux.dev>; Tue, 19 Sep 2023 12:01:16 +0000 (UTC)
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id DAB5F240101
	for <iwd@lists.linux.dev>; Tue, 19 Sep 2023 13:51:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1695124289; bh=JZz7NwFOFxCQ8QzZWUhqaZCBnliNB5HBvAwArE1R2t8=;
	h=Mime-Version:Content-Transfer-Encoding:Date:From:To:Subject:
	 Message-Id:From;
	b=BjDscIQQemLQxD+QMOZk5PK3fxKuVqz9pe9LHc4f5wjCQWJPYEf5EnRx/hlHRWoD2
	 eWDbeyWHTY9IeSG3VI4HFpTumSpp2qenzQZh9WrtOeJYe2Tj5/gtWtzk+Njozz6+oj
	 CT3nmF+v9Eqci0xpNdtvjV2cV/ZsfTK97tPLVBOsoABC+abgN+wvd6qptdyEgnfIq5
	 Bblg/fec8ZI3EMJhhu5nqQWkZHALA0UskEUNOCp5BFMPywAQxtsHGu5cfK/tEQ3JkZ
	 yrdCmSRaPESZTz9vfVH0fms3H9wMMndbYsDi4WVGaWiqr8jk/VC1xu8kr+gV7yFq3F
	 JeA8bqkH3uc6w==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Rqg413DX7z6tvs
	for <iwd@lists.linux.dev>; Tue, 19 Sep 2023 13:51:29 +0200 (CEST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Sep 2023 11:51:29 +0000
From: "Sertonix" <sertonix@posteo.net>
To: <iwd@lists.linux.dev>
Subject: [PATCH] test: log correct function name
Message-Id: <CVMUXBOJCCQ3.3DY5I2CD7ES6U@sert-surfa-alpine>

Matched the printed function name with the actuall function name.

The simple-agent test prints the function name to allow easier debugging.

One name was not set currectly (most likely through copy pasting).

---
 test/simple-agent | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/simple-agent b/test/simple-agent
index cdfc2076..f34c04f4 100755
--- a/test/simple-agent
+++ b/test/simple-agent
@@ -54,7 +54,7 @@ class Agent(dbus.service.Object):
                             in_signature=3D'o',
                             out_signature=3D'ss')
     def RequestUserNameAndPassword(self, path):
-        print("RequestPrivateKeyPassphrase (%s)" % (path))
+        print("RequestUserNameAndPassword (%s)" % (path))
=20
         print("Service credentials requested, type cancel to cancel")
         user =3D input('User name: ')
--=20
2.42.0

