Received: from smtp161.vfemail.net (smtp161.vfemail.net [146.59.185.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8E61FC2
	for <iwd@lists.linux.dev>; Sun,  9 Apr 2023 11:40:24 +0000 (UTC)
Received: (qmail 5045 invoked from network); 9 Apr 2023 11:33:41 +0000
Received: from localhost (HELO nl101-3.vfemail.net) ()
  by smtpout.vfemail.net with ESMTPS (ECDHE-RSA-AES256-GCM-SHA384 encrypted); 9 Apr 2023 11:33:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=openmail.cc; h=date:from
	:to:subject:message-id:mime-version:content-type; s=2018; bh=Yve
	mxDP5F2iVyRTRMztcPi/31Bux/GEy/NoBQxMMv1c=; b=IKOPEuZiguKCwc9e1pd
	7bkfshHMU3A94inIW6DF7gxYVadvQHEe/2Yj28DHSn4aIBq5BwPNt8KDRFFkxuPO
	sZV2BXlPgrwsxhpHFn8kS/KhOGM+asiK5YDWVob6y2FBDTl46isXRopYe3I0F0Pm
	VEt7y2cVGfMimZSMMOvYN94k=
Received: (qmail 31497 invoked from network); 9 Apr 2023 11:33:40 -0000
Received: by simscan 1.4.0 ppid: 31490, pid: 31495, t: 0.1203s
         scanners:none
Received: from unknown (HELO bmwxMDEudmZlbWFpbC5uZXQ=) (bWFuZGF5QG9wZW5tYWlsLmNj@MTkyLjE2OC4xLjE5Mg==)
  by nl101.vfemail.net with ESMTPA; 9 Apr 2023 11:33:40 -0000
Date: Sun, 9 Apr 2023 14:33:49 +0300
From: Cedric Sodhi <ManDay@openmail.cc>
To: iwd@lists.linux.dev
Subject: Initial choice of network should consider RSSI?
Message-ID: <ZDKinaeLzoAvaIb1@air>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I have a permanent problem with IWD when multiple known networks (different SSIDs) are in range: With a large probably (although it is most likely just random, depending on when the beacons fire) IWD manages to connect to a network with an unusable low RSSI while better networks are available.

I suspect there is currently no logic in place which would somehow work in favor of making a "good" choice? RoamThreshold, for example, doesn't seem to apply and InitialPeriodicScanInterval seems to have no effect either, given that the (initial) connection to the (bad) network happens immediately before InitialPeriodicScanInterval passed, and that choice does not seem to be revised even if the better network becomes visible within InitialPeriodicScanInterval.

Would it possible to either extend the meaning of InitialPeriodicScanInterval or introduce another option which would allow IWD to connect to a better, different SSID (thus not covered by roaming) within an initial period?

Cedric (please CC)
