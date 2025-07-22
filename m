Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564A42D1F61
	for <iwd@lists.linux.dev>; Tue, 22 Jul 2025 13:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753191410; cv=none; b=lLVb9R2O2vJx0aMMYBMQ7RZF82eBDJ9bbx4fRrsB6stGKlDoCByLUBxxl/Np1C8/5u9PUIe5K5UatDOtThPBwuO1Mbj63zifBqlNUcGXqwckIgBhvDwwSw0oIDa6AcMUsQl1JkAPlAkWDr2AdEsVnmjbHohAAPJe7jetfmvgWkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753191410; c=relaxed/simple;
	bh=vm7ZvLalNUDGDZufMOo2pnejelJ8LFin68jt5+V0lTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQRMRDSXkkTTEU0MfLPKyHeV2CRIMp91/B3oM2ZycyU960mhEGL0FiFOioiApI67n2izEbybgcOYnpKf04+81fI//0ynosGzLhJ1cxqWozVKGlSGZ2BPd0Dhbkkxet65NzJ4MyhYmg9D7lDZWVOTMvbxIst8QMr6OGUoHByC1+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e8d707b9bc2so4160391276.3
        for <iwd@lists.linux.dev>; Tue, 22 Jul 2025 06:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753191407; x=1753796207;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YDN3bjbntNYnttipBmCZRulatFyP6eMox586K+pRSM4=;
        b=wznsq0hqs7DqKdMWYREMpdIlwT4Q2JOrGNIcxgxFAHOHZW7+sSj2TeSWS07EfGetVy
         ruDBb7my4jx4VPMHmuPZOaw9Juv+OXRR6PK1iwrfusk3vJbRlNeeJ+aoRcvYkKxq1AAD
         iE3BgtHNH+0nSzjr/e2FpesJiPc/R1IrB4UM+fADpNI+liZTiEIcV7j4jcn8aW+0N8b5
         7we+6UCSaLoKDCS1ROsIQ9AEKbKDYGmjAr0o+bCF5Czz4fEqXeiVBKDez4PN9PpzpVfJ
         1/PxZwlWrKac4P28qHMU98BSIE+eTVAckGznbgtSq/KWrf7dBhogGfD5uQkiMzdKFvVf
         fwpQ==
X-Gm-Message-State: AOJu0YwO5AGuNP+yieisuvYJI6HqSS06NOtZDJiWZE5oi/+ihFto45H2
	klmJaHd6tU6v8FAXJq80aAW+JDlKjVxHUjZ6lLufiEDMFSt+H+YsmiWSEjw/nA==
X-Gm-Gg: ASbGncsYTLC0uTZKf1Mdz1Nmzhyt3XMCRUUpZsltEcIEfxVX4lUB0kFx16taFNZiYl4
	uux2NehLMdAJoGMZAZcmPNVISCclu6clq2YlszMithFRsILIMP4hQqe8msLWnF/azOKWlRVUqAE
	H/WWSFhrHP55kniStLF8EESpxTUKk8p7DyJGyhfxPtqR8faNPe5JCLndJl0QdIhWWXYvpL7Arkf
	EAVvSwshLhkBsmGs66pZdMINDsm+XVWpJg2uO4ExMtSkEDLOZwUv5QgwRMhy8EhK4fXZC+opzvn
	DJH4iw2E4VGSnws/v7eL/ZvPP17Zulaa2+/FA7ZgiP9iWRRXVo/3TxKWLnZTRZTgBbj4Bc0x1kE
	ZHh7qrmIVJ9Pgt3rHzep77moB/Ycypt1g/7VNfd+CLrGZV5xMYeZTZqrg2l27tEcOuw==
X-Google-Smtp-Source: AGHT+IGktFapubIUcVLkGOqgylydgFN22KD5Er8ZDpz68xmJUnsBySFAd6d8CnsuUH30z+T21PQMAA==
X-Received: by 2002:a5b:403:0:b0:e89:8cc2:8082 with SMTP id 3f1490d57ef6-e8bc1d819cdmr26456881276.41.1753191406918;
        Tue, 22 Jul 2025 06:36:46 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8d7cc39897sm3174569276.14.2025.07.22.06.36.46
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 06:36:46 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e8d7ad77e4cso3871819276.1
        for <iwd@lists.linux.dev>; Tue, 22 Jul 2025 06:36:46 -0700 (PDT)
X-Received: by 2002:a05:690c:7487:b0:710:f6eb:9b33 with SMTP id
 00721157ae682-71834f7c924mr337785807b3.15.1753191406083; Tue, 22 Jul 2025
 06:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADXxVSK3vr5=wsB8q6yz1KvB5VqSnQNW+8Nf_Wn7OrAQN470Kw@mail.gmail.com>
 <ed371e7d-e89c-4e3a-aa84-46535c613b35@gmail.com>
In-Reply-To: <ed371e7d-e89c-4e3a-aa84-46535c613b35@gmail.com>
From: Bryce Johnson <bryce@redpinelabs.com>
Date: Tue, 22 Jul 2025 07:36:35 -0600
X-Gmail-Original-Message-ID: <CADXxVSLXWPG7iV7p9OccmHztgA23y2KHuP3kcEisdDHdtiMiqg@mail.gmail.com>
X-Gm-Features: Ac12FXyQbBxMTWzY-kXezmaiuRji-2XdQzQOV4vxz98eaQH4wxvnG1hGvVaiR8s
Message-ID: <CADXxVSLXWPG7iV7p9OccmHztgA23y2KHuP3kcEisdDHdtiMiqg@mail.gmail.com>
Subject: Re: Dealing with wifi driver crash that doesn't remove wlan interface
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi James,
Thanks for the response.
>
> I'm not sure there is much within IWD that can be done. I've run into
> similar problems and about all you can do is implement some kind of
> watchdog which monitors for these conditions (which sounds like you've
> done). The difficult part is detecting these conditions. I've even
> monitored journalctl and scraped IWD logs to gain more state info about
> IWD than what is advertised on DBus. This is actually why I added the
> l_notice "events" to IWD, the idea being that they are a consistently
> formatted, tool parse-able lines containing additional information, e.g.
>
> event: roam-info, bss: aa:bb:cc:dd:ee:ff, signal: -41, load: 9/255
>
Yeah I'm on watchdog v2 and thought it covered everything, but looks
like I need to add some more checks for this more rare case. (Only
seen once or twice so far)  For the most part I don't have direct
access to the devices, so I just get the logs, need to try a fix and
see if that reduces the issues.

Bryce
