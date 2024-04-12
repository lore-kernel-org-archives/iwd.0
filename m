Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CB481AB7
	for <iwd@lists.linux.dev>; Fri, 12 Apr 2024 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712943677; cv=none; b=j8K2wcgj0WSXofBZV9J6zEDBM2TgsQqQ26Ruyt5lh0PSaDF8X/lr7ex0D5E2fJf4gDQP7nm4n6BI0XJtyYUhBLhunlXLmb0GsyOhiQhMd7c/p88pcD6j1L5dgSLPjwf3wU03cPiYKXSouNu3nMEcYtqIx/sDQ5qQXacwI3kyaJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712943677; c=relaxed/simple;
	bh=ZE91lHaQCeg9i7/u+TJ71kkoZThOn/+1NGJPe3uTHww=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=fBHlXCaEfM3dAUWM8huG7k/95pk65ekjjGSQNEPpYEFvs+sfmfUxtgl6etrEB709/1V8fEY2cp4bmneUmDbX0pUm3dj2mxEVksOigoVJoOUtl3H8MSugmun6o09VyAsK8wmTmIMDbcl691bY0XtdGaITJyYgQvy5htBB42tw8uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8SmuO9f; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8SmuO9f"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2a3095907ffso749570a91.0
        for <iwd@lists.linux.dev>; Fri, 12 Apr 2024 10:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712943675; x=1713548475; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZE91lHaQCeg9i7/u+TJ71kkoZThOn/+1NGJPe3uTHww=;
        b=F8SmuO9fnyQiSoMp/P1ewJk6/gOZxJqWNhZ4oSi+tNyhueSM5aLza1mlHETFMFDyon
         2W+bn1yLU2/h7LUQBFLITCIkuotbOqfkQKp8G1iM4wma17u6qBla98pdZU5LocAni2E4
         fWixK5/CBiNoYNuK/S7arYAIhdo+AAGX1Pv7cfj38OGLb1dEI21e0GQ1+UlPpZGLb6WJ
         JFPpm6B1C1btAbMP6uUh84728/1s+sZYsFjwSnG2w5ddhMkXRU708W5Nd+5CK23m6Rbg
         8R4aR/PSw9cUivkYsQq/soWNOXxhWvcUy1Vu1c3B+bJEC/YSsuLCbyPM7bToPKWXKVA6
         jiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712943675; x=1713548475;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZE91lHaQCeg9i7/u+TJ71kkoZThOn/+1NGJPe3uTHww=;
        b=gsVQ35peyP8VyRt12sUPJ2Rjx03DM9efRsJdi+4MpkldYMyYfZ8gpRapN9ONYmr+eF
         d5jXjiqsKTiwfes8L1WiovuhYRt17gnWIZXmrA6Ry8QczceJBQ814La2SODyNF1h+ynj
         t5QKhnZ5bT1TnEqS3iXlGGwOVaqb94oPpvFbmg0JR535MwzbwYva/YPFt6mAyG6EOMLI
         iNagaXE0od3xgwccIKv7rMTMNfAVex0TDYGy189vCQOmlTDwXrve+KgDRSXQHZ3wMpa+
         4LHQ41z5mh0YAtFnWGzSOXqJPNzyiVfdQkRZQ1KYKAbtGhuMj8pAE6bNuIxBWz3TuieZ
         4/UA==
X-Gm-Message-State: AOJu0YxlzD/5w88/bSgPywDYsu+Gu2CzDt4BWX/OLL0XaeWOO9QDdv/i
	iSmIfxscgC3H/WO389/fllvoD4lbVWYIjZg0Yc9kM7lJRr0ZP8YURp6JBTT3bGvhcpFsKihlr0/
	/rlQJiVaOcfCGyR88GBVNHPnk0ooz0DIe
X-Google-Smtp-Source: AGHT+IHKHl7Gs/lzoqpED/G8bsobURO3qYOdTkGTjErMRri2RvWqkloQLgE0l1BKtoIjWfLCX1++Zfm9YX0GPqFhCGU=
X-Received: by 2002:a17:90b:46d8:b0:2a7:4e38:70e9 with SMTP id
 jx24-20020a17090b46d800b002a74e3870e9mr841298pjb.13.1712943675539; Fri, 12
 Apr 2024 10:41:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Date: Fri, 12 Apr 2024 12:41:04 -0500
Message-ID: <CAG17S_OZt84p8HQ4E189+VTMssSrDBDXNzeMUT_hZb=jbuKE6Q@mail.gmail.com>
Subject: NT/VHT errors filling log
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Group,

This is on a Pi5. this is with the 'current from git' build of iwd.
iwd-git/now 2.17.r0.g468cecdb-1
These are new errors which are showing up in the log and recur a lot:
Apr 12 12:14:17 pi5 iwd[1537]: error parsing HT capabilities
Apr 12 12:14:17 pi5 iwd[1537]: error parsing non-HT rates
Apr 12 12:14:17 pi5 iwd[1537]: error parsing VHT capabilities
Apr 12 12:14:17 pi5 iwd[1537]: error parsing HT capabilities
Apr 12 12:14:17 pi5 iwd[1537]: error parsing non-HT rates

My guess is the brcmfmac card is not reporting properly to iwd.

Is there a setting in main.conf we should have for this card?

Keith
