Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DBD3212
	for <iwd@lists.linux.dev>; Mon, 12 Dec 2022 17:22:56 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so550689pje.5
        for <iwd@lists.linux.dev>; Mon, 12 Dec 2022 09:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGQChT+pbLRWK1oqD2tcGw4f+d9JxcgEy9uapmmsJR4=;
        b=pZRwaaVEPwiDFvWSEfLRBOD3U8o3P7s4yVi8D/DuHX8mdcejqp3PAoY6B2bFlHy7RS
         hcyAaNITLFYzjgE8fOBop+dyDF1Qbg4ZqzQKZSF+8qgQ4GWRvSneelOv4Jc+fnA8mwkS
         aNfcCq/jUPJVES85HxxflMX4T0sfSy66vn9DzhKMEegIXWlNtSvlYYSt8ZQJFfgPBFSk
         1S0qTQrSqsCegb1W7UfGrCfFf8RPecKpTtM+R4oaG+YVP4ZIVoYKF9J9ufMN4a1E8XI7
         Ev8WU4QgjQOkOeKWdcKFB4vKTEWyrao8DccJ9A5GJOpPppWSkwM5OQUCj+zwKotLnspf
         RsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YGQChT+pbLRWK1oqD2tcGw4f+d9JxcgEy9uapmmsJR4=;
        b=WOO16Nut96uV12QsPAZs2lobuTSP7NDpI2gLCMRtHYkg9NtB0fZP8dOEXVO++8X2Nq
         LM18OU8GRDd5ebqebvkzb4fMjW3P+XuFf1WIuFcotCKhS/T8JBX0Zb6jNZ94TXo058hs
         t9oxI7cu48aeDdVNb/9hDimEFctYGyPY1Dqo5TfH+wuK6zMnUG7IVrRSZUgHNgMSjzfr
         g/5ofTsAXFOZMcVjzNpwOJrfUkbxlxBbDt6f1z2QcG0/VF21YV3uLk57dNkOfq/2E/C7
         4M6mHUUO+UyXex0Jz/loq3Kag6aF1ANjauXvS46mXeiESM0Y0mID2H6fg4rxR1VGxGOX
         2CIQ==
X-Gm-Message-State: ANoB5pk3ZvIdSy1WclXK47i9cD0c9lCTU4+g0bMnOFx4d2aNf3c/hdYM
	QRO07SEtuG1UTOruFGr41QniiW1EXQk=
X-Google-Smtp-Source: AA0mqf4yntBVbDBHtdQJDAxdsHo9N42ObWCWYpQzh0dPMNPrCVyeHB27X6LiaxuNYXUYQX0ZbXvjeA==
X-Received: by 2002:a17:902:d2cb:b0:188:8679:bb1e with SMTP id n11-20020a170902d2cb00b001888679bb1emr25112752plc.46.1670865775621;
        Mon, 12 Dec 2022 09:22:55 -0800 (PST)
Received: from [192.168.254.17] ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id w11-20020a170902ca0b00b001872999f58esm6600110pld.189.2022.12.12.09.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 09:22:55 -0800 (PST)
Message-ID: <b4ad714bbd162b1f7bc3302c9585adf8811ac929.camel@gmail.com>
Subject: Re: iwd release 1.30 onwards cannot find available networks
From: James Prestwood <prestwoj@gmail.com>
To: Bruno Dantas <dantas@airpost.net>, iwd@lists.linux.dev
Date: Mon, 12 Dec 2022 09:22:54 -0800
In-Reply-To: <b7ff5956-f571-d9d8-1f7b-f3025e2055ae@airpost.net>
References: <b7ff5956-f571-d9d8-1f7b-f3025e2055ae@airpost.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Bruno,

On Mon, 2022-12-12 at 11:54 -0500, Bruno Dantas wrote:
> I was a happy iwd user through release 1.29. From 1.30 onwards
> (including the latest version 2.0) I had to switch to wpa_supplicant
> because in most (but, strangely, not all) locations where I go, iwd
> fails to find any available networks ("sudo iwctl station wlan0 get-
> networks" says "No networks available").
> 
> Today I finally got around to doing a git bisect to pinpoint the
> regression. The bisect concluded with this:
> 
> dfcba7c83c60f1a99ecf6f1424e97bf89fcab38e is the first bad commit
> commit dfcba7c83c60f1a99ecf6f1424e97bf89fcab38e
> Author: James Prestwood <prestwoj@gmail.com>
> Date:   Thu Aug 4 11:51:06 2022 -0700
> 
>     wiphy: track GET_REG ID
>     
>     Keep track of the GET_REG call so it can be canceled if the wiphy
>     goes down.
> 
>  src/wiphy.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Thanks for taking initiative and bisecting. But its puzzling how this
commit could have any effect. The only functional change is removing a
pending request when the wiphy goes down, so not related to anything
while the device is up/scanning.

Just to be clear, you are making sure IWD scans prior to calling 'get-
networks' right? i.e. station wlan0 scan?

But assuming IWD is scanning (or trying) we need to see some debug logs
for IWD, and best if you could also get an iwmon trace when IWD starts
up and issues scans, and when you call get-networks. More info how to
do that here:

https://iwd.wiki.kernel.org/debugging

Btw, Alvin just sent a revert related to scanning [1]. I have't had a
chance to really look at it but possibly related?

[1]
https://lore.kernel.org/iwd/20221212164250.3075444-1-alvin@pqrs.dk/T/#u

Thanks,
James

> 
> In case it's helpful, my machine is an X230 ThinkPad with coreboot,
> linux kernel version 5.15.10, running Tiny Core Linux 13.1 x86_64. My
> wireless card is Intel Dual Band Wireless-AC 7265. If you guys need any
> more information, I'd love to help.
> 
> Please fix this regression if possible. I'd love to go back to using
> iwd in the future.
> 
> Happy hacking!
> Bruno "GNUser" Dantas
> 
>  
> 


