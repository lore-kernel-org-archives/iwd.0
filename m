Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07B77B
	for <iwd@lists.linux.dev>; Tue,  1 Nov 2022 20:54:37 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id c24so14683195pls.9
        for <iwd@lists.linux.dev>; Tue, 01 Nov 2022 13:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qr++oEPEKMgxj5Ei3SvWAGcP7Tdf1gW+RtjzNceviRw=;
        b=mkxWNf3G0N+2A6wW6BsdBhR8rlamDWl1o2KEzIHtvbOIO4mramqS8SjfwjDESSTgXS
         HxJTZ/ZQa8y3jUo7CAQeC7bsBmXf48d0BzCvq1IptuNnvMudoWmOEe9i1pKlAUbkSMVH
         QunX5wjmyuFSmuqlwrIXr7XR/MAeLqb5PLuQAeS3lsdeh/pP0ejgs4RYnEIIPPAk/wqg
         LwUIZneBPlkyvRLnNDbgM7jpBId+aeqCTd2QhfGbCWj/4CvTHTtIAKATDUDgkos3qxfJ
         qdFTVAshYytTY6yPZogGtw/dYnrVEzCGAmiknVI6hZ2BwMZFZ3paQX+OpNQGKsvfU4zl
         +kwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qr++oEPEKMgxj5Ei3SvWAGcP7Tdf1gW+RtjzNceviRw=;
        b=hW+qdfJ78CKYA5KqnwCQegytZs8LmniwGztZ7U84ov4+srfofLlq3Vjf1Y/Hg01tIg
         fiGsybFvezTEnuJfEskI2TGt0P15GKQaEPRLgM+8QLyGA6e7FXhX/rif7ZCNqG6aEUJb
         bkkKqNEZVN1OjSCeq8hG8NI1swh302EkKl/sctUJg4LT8WrUEEsXMEgPqKFgMkEx4krQ
         /R56DJTiav2pOYU+Ob50KRN0RUhdJYP7df1l+nZ+hFW9vlCwh4rD1FmOCUgVodtvTiJo
         ThGuBx2RCpkiincT5mWAitoSYcIs47e1+6HUjE3oQ4s8cKgARxr8oAWEJLTzTlfJbSJr
         O5bw==
X-Gm-Message-State: ACrzQf2re+nUVDECPd/FeEquTisuwJCZvPTRe8pRXSYtHmIHueHsVerg
	PpE1IuRO8FOoVLGD+MVe/AGj61TuTKc=
X-Google-Smtp-Source: AMsMyM7I+30MTwjCxWpf+zZol+m2VIEXeKiFAHOnrT6AxnNxHNuWqrD9n2IlU0FRyBaguphmM1COZA==
X-Received: by 2002:a17:90a:df91:b0:213:8a69:c504 with SMTP id p17-20020a17090adf9100b002138a69c504mr27705152pjv.82.1667336077311;
        Tue, 01 Nov 2022 13:54:37 -0700 (PDT)
Received: from [192.168.254.15] ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id ja1-20020a170902efc100b00186b86ed450sm6795268plb.156.2022.11.01.13.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:54:37 -0700 (PDT)
Message-ID: <66b9f15578d9f7112e532a7174268b02b629360f.camel@gmail.com>
Subject: Re: MulticastDNS for all connections
From: James Prestwood <prestwoj@gmail.com>
To: Andrea Pappacoda <andrea@pappacoda.it>, iwd@lists.linux.dev
Date: Tue, 01 Nov 2022 13:54:36 -0700
In-Reply-To: <A4TIKR.5DC9OCNE90W6@pappacoda.it>
References: <A4TIKR.5DC9OCNE90W6@pappacoda.it>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Sat, 2022-10-29 at 17:16 +0200, Andrea Pappacoda wrote:
> Hi all!
> 
> I have a question regarding the usage of iwd, specifically about the 
> MulticastDNS option. Is it possible to enable it for all the
> networks?
> 
> The iwd.network(5) manual page mentions that one can enable 
> MulticastDNS for a particular network, but it also says that "The
> group 
> [Network] contains general network settings and any network specific 
> overrides for global defaults defined in the main iwd configuration 
> file.". Unfortunately though, setting MulticastDNS=true in 
> /etc/iwd/main.conf does not lead to my desired result.
> 
> I'm not using neither systemd-networkd, ConnMan nor NetworkManager.
> 
> If this is not the most appropriate place where to discuss about 
> feature requests, feel free to redirect me to the right place :)
> 
> Thanks!

First, I don't know much about mDNS :) but anyways...

Currently the MulticastDNS option is only per-network, but systemd-
resolved has a global setting itself according to the docs [1].

But I actually wonder if event setting MulticastDNS in IWD is doing
anything:

"Multicast DNS will be enabled on a link only if the per-link and the
global setting is on."

This would imply you need to set /etc/systemd/resolved.conf with
MulticastDNS=true to even use mDNS at all? Or maybe you have already
done this? And I see the problem, per-link settings are only in
systemd-networkd, which you don't use...

Like I said, I don't know much about mDNS but would a global option
'break' networks which don't support mDNS? Are you frequently
connecting to many networks and needed to add this option to the
profile each time?

The fact that this depends on setting systemd-resolved's global option
and the per-link option I would say this really should stay in systemd-
* itself. The IWD setting is kinda useless without the global option
anyways. Plus systemd-networkd is much more flexible, you can match
based on all kinds of things where IWD is very rigid (global or per-
network).

[1] https://www.freedesktop.org/software/systemd/man/resolved.conf.html
> 
> 
> 


