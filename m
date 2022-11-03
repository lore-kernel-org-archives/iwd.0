Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232E07470
	for <iwd@lists.linux.dev>; Thu,  3 Nov 2022 14:24:25 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id s196so1803970pgs.3
        for <iwd@lists.linux.dev>; Thu, 03 Nov 2022 07:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YMfxKX+0fViDNAyTxSqK4k+YAVdb4Q+QYEIDWbqTelo=;
        b=lpqXgyrvgfuafShLHyVohLO0lwCgE0Aft6lTLdh3mOUzu57DdYIjiu7C89qpN1ZY9R
         yp3UBbjZFrg1WF23SLhEbAfl/m1JKTu/zlIpI1rQSTkRaL9/ZohWP8KbX6ectcA/6IZ+
         24oTxkjUSGGGgpcwdNiIymDDgFiqIsKFiS21S6Abl2+vr5lmepT+ttv7GV0PhuIEkKaX
         FetMEPWbLSOlraiugXnSJpzQPK0ovLXqORO9CZ+WhKQLsJThyPEtfMFbZOB6IL5GEVmU
         xIKtNqE6A9ZQB2AJ8zzQS5odIdrN1eZKJs51/Rwot0kCiR0F+mSNJlUAFXrxxY7mpyKn
         1O3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YMfxKX+0fViDNAyTxSqK4k+YAVdb4Q+QYEIDWbqTelo=;
        b=Ru6fuUsMmMIWWgxuAm8j0VpWgwpTC1JM+EKViZg/jljk90TXJFrwyxPJhiQpHmHz2d
         HbKGaMx7mHGAQtKUaZ3m0bac5PihjbmXaJk8cew1rfYzZk7P2mIvvleBaJIusTI8Cfta
         p0BLuNCWcxpVKSxRo3hrCsK3llkrUxxV3AFZn6OwaiA/uds2vj49gUF9+ZKpajCPG5Os
         GQ72WDJ112JghqUzQ8NhklwAtBweqgey14A2TVIpFCdosBIUmAr1UUj5ZrQzE+fgAdx7
         JTYznHrUD4jKePolLze/LmxMcIsi2lGSAmoSjEm2WUxIWB0sLCiAZ/WgSV+Cm05MxTZm
         sEYQ==
X-Gm-Message-State: ACrzQf0Zw/cRsxWgosye4TRbkA3INe0K+1PvuXrGgyPbumb9fyJKzW8l
	Ed7qry6OyaYx2svs7I5SkDm2Yt1sD6Dsm1XfbR4=
X-Google-Smtp-Source: AMsMyM6fYpTT6zkPssAmqjkY5kDyFp0+UN40vE15AluznGwv7iRrkOC6felOvjhJFkMTsu98eSGDlwh1hNI2o4Rwvwg=
X-Received: by 2002:a05:6a00:22c3:b0:56b:f793:5ad1 with SMTP id
 f3-20020a056a0022c300b0056bf7935ad1mr30905711pfj.58.1667485464552; Thu, 03
 Nov 2022 07:24:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221103105639.8289-1-andrea@pappacoda.it>
In-Reply-To: <20221103105639.8289-1-andrea@pappacoda.it>
From: Rhys Perry <rhysperry111@gmail.com>
Date: Thu, 3 Nov 2022 14:23:57 +0000
Message-ID: <CAGTBY+uDse4b5KzLmVN1Xx5w6bnYAgzT+hO9GPxzavP-8UiHeA@mail.gmail.com>
Subject: Re: [PATCH 1/2] netconfig: add global MulticastDNS option
To: Andrea Pappacoda <andrea@pappacoda.it>
Cc: iwd@lists.linux.dev, James Prestwood <prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> Adds the MulticastDNS option globally to main.conf. If set all
> network connections (when netconfig is enabled) will set mDNS
> support into the resolver. Note that an individual network profile
> can still override the global value if it sets MulticastDNS.

Since we're getting a global setting for mDNS, would it make sense to
add a global setting for DNS at the same time too?
