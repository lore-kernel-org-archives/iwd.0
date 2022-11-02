Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1646824F2B
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 22:06:51 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so3438878pjk.2
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 15:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0NLdXAL5YP4zduxghmRCSTe793XFHyOezfBmngx1W6s=;
        b=eVrsbHo42GAMKKUgo9OhqiURfdVkzulbi7ZmHyYDUtOuBh+HUKSBFQ3P3bIf0o28O/
         cpHsuQa5MefgJ2wknRPIASh8UNTfJFbnN31Y/DIUltms+PUNyFO631PCA2z3KA+xTR76
         wo/gGqqa1AJddx5fx0yGndDNQfNtmK/oe0OLo5a6UPZy4fCb/p9+3ecgHpY8tZ0Zf00x
         xtGvGBYnBaRIOMVgBs+xMXGeelvc/CIQrxmx8y7XFJcF/AeI6ScOhT0xdp2Sy4ecUbm7
         cah8apHakWzlQWlm9QZw6udoQ7bSBhlfJfSfBBYsX19J/sorHIMebnQbsobC5r1+z3Gs
         m1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0NLdXAL5YP4zduxghmRCSTe793XFHyOezfBmngx1W6s=;
        b=v/kjsKmEeND7axNRD/0uPb0+kZRDkgjb5IXzFEXwOpWOVh3wK2aHjXX3e0u8z+6wnr
         m8z0GoOcp0+S8KlgAusY8OxJE0ew2bvS5CcEzM63HCMciuxdeaVzjJWtIf9qYzjd2Vgj
         eLgWEtd3q38/dx51HaoO1yRC3RVX+xo/GW/cM0sYX7g3c013+B2vNl7pq0Wf8Cnc7yrI
         sbihQl5jMfllFOcPNpEe5oGHr8qC60YUny/OZ963wpKpXPpNVQx7pXTuByr7pOku/UeQ
         g70Rpe5H5VwjuUU46+aIyXoaYYZc0WriirebNaOSiKhMBNK6t58FxZSW/+ZrWw/reiwp
         1lnA==
X-Gm-Message-State: ACrzQf2gbI+y+Ndi+LZGgwvluohRGQaaeZ9Hne7xExf/gfYD2xUMmv8b
	SjK6NFR+9QMAtlW6dnpkOP3sJ6q9pYE=
X-Google-Smtp-Source: AMsMyM4xXx47bXTE2oCM8q+abt4R4wksuh1BqSUqA7bGj5q3/aETLp39mfVdXBN7QyzmRqKK6jVV+Q==
X-Received: by 2002:a17:903:54a:b0:186:c41b:dd7f with SMTP id jo10-20020a170903054a00b00186c41bdd7fmr27136673plb.33.1667426811421;
        Wed, 02 Nov 2022 15:06:51 -0700 (PDT)
Received: from [192.168.254.15] ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id o6-20020a170902778600b001867fb4056asm8766440pll.32.2022.11.02.15.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 15:06:51 -0700 (PDT)
Message-ID: <4e8fa823bba31d2952f24b00b8a228a14aed1c05.camel@gmail.com>
Subject: Re: MulticastDNS for all connections
From: James Prestwood <prestwoj@gmail.com>
To: Andrea Pappacoda <andrea@pappacoda.it>
Cc: iwd@lists.linux.dev
Date: Wed, 02 Nov 2022 15:06:50 -0700
In-Reply-To: <78QQKR.LWXY3PZ4TZEX@pappacoda.it>
References: <A4TIKR.5DC9OCNE90W6@pappacoda.it>
	 <66b9f15578d9f7112e532a7174268b02b629360f.camel@gmail.com>
	 <CZLQKR.DUWHOW09XS8D@pappacoda.it>
	 <c1a5ac7f3d1efb63c66218c147d6188e3e8ebc51.camel@gmail.com>
	 <78QQKR.LWXY3PZ4TZEX@pappacoda.it>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2022-11-02 at 22:55 +0100, Andrea Pappacoda wrote:
> Il giorno mer 2 nov 2022 alle 13:47:57 -07:00:00, James Prestwood 
> <prestwoj@gmail.com> ha scritto:
> > I've attached a patch if you want to try it out. I quickly tested
> > only
> > that "resolvectl status" showed +mDNS or -mDNS depending on what it
> > was
> > set to. In actuality this is probably enough since all we do is set
> > the
> > value to systemd and let it handle it.
> 
> Thanks James, I can confirm that this works for me too.
> 
> I'll be using this patch locally for the time being, but it would be 
> great to get this merged; I can update the documentation too and
> submit 
> everything as a patch to the mailing list if you want (of course, you
> could do this yourself if you prefer) :)

I think Denis could merge the patch I attached, if he's ok with it of
course. If you want to do the documentation go for it! If not I'll get
around to it this week.

Thanks,
James

> 
> Thanks again!
> 
> 


