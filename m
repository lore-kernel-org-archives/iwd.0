Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF8E110B
	for <iwd@lists.linux.dev>; Thu,  2 Mar 2023 16:15:33 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so3255338pjg.4
        for <iwd@lists.linux.dev>; Thu, 02 Mar 2023 08:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=innb/tDCqU5/vy9dvqhXOR5Xc91fjZwNkFJk5LsFNCQ=;
        b=pJIZCbOFa+vzLvDId8LcENtEz5tEjd1UjacrRiDnaxW96zzxsc7HRvlJLxHjvIubhS
         18qB4zBFSShlhsAyudgPF2KtmpNSERWtMnaLcl7jcYykKALHWjbdEWvi1bEt07ilQETX
         V/1C12sjECBxkuOqPiYkS7tzFktTcREHpcYZcLgpUAe+fbpv2k0vRz9IB1gxikVD4hUG
         Cc/xbmbkcg30uPR407RGFVAcKGGZiCifQg0o0YBfvDo9l8hxVH5FDztYFgiPQDluHBIi
         +JEA5D13VPlWqDI9wjA7JSMq2nDfqzlQGNkjrJhoHbwBNecGTYR5vXGf23aoRUSslJu2
         Lnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=innb/tDCqU5/vy9dvqhXOR5Xc91fjZwNkFJk5LsFNCQ=;
        b=HRLOHw/ViqtgJmlHzSGikRYDyLEzW6HcPawf5F8IDVf4sOJlk9vhjEa81Yq4XpyERC
         WIZ2VKC78RYqO06GjLOp63OxiyVJ+ta9jMQfCmOk8M2TfXscogtu6uX+UjTk2n1BQ7n+
         76skeIW14/4oT30p2iz6puGpez0o//8Uvu2UELfSK0MEjOYilLVP55PHkdpGFH2sAzYP
         jkM8xe5NalCbvB3WznHZ88dG7nf9M0kL+taL03yASHJEEbrffK6x4O41QwozcjE+gFVk
         wI69KKfIDmg7uGB7WZsVT3uYHwQ8NoFDR3eDsDvEyXUQWk7BshhfRBNydmW1IvACmCT/
         1Mkg==
X-Gm-Message-State: AO0yUKW/MyXnBXPxtC6rxMFBE2sajbaFHQvrDejUnRaPDU3+BakoY/dg
	3Xn7lJoB88QJGr9KCXKIP9s=
X-Google-Smtp-Source: AK7set+KsSV4szbhaOeEFimCNV5kz8KCtAaVqDU+zQq4oo++O7oC+UkmtAPRmmsKel6+JOKt5IS3qQ==
X-Received: by 2002:a17:902:ce88:b0:198:9e29:cc4f with SMTP id f8-20020a170902ce8800b001989e29cc4fmr12189113plg.43.1677773732462;
        Thu, 02 Mar 2023 08:15:32 -0800 (PST)
Received: from ?IPv6:2806:101e:7:f6a9:2cfa:b2ff:fe8b:6376? ([2806:101e:7:f6a9:2cfa:b2ff:fe8b:6376])
        by smtp.gmail.com with ESMTPSA id ix1-20020a170902f80100b0019ac5d3ee9dsm10647685plb.157.2023.03.02.08.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 08:15:32 -0800 (PST)
Message-ID: <152dff569b6fba0baadd7ac14673cf2a67c42eb4.camel@gmail.com>
Subject: Re: iwd ap mode changed?
From: James Prestwood <prestwoj@gmail.com>
To: KeithG <ys3al35l@gmail.com>, iwd@lists.linux.dev
Date: Thu, 02 Mar 2023 08:15:30 -0800
In-Reply-To: <CAG17S_OaL_VK9e-s=DbwwKOAdjX9jR_B9ogifs9Di1-VW=ksmQ@mail.gmail.com>
References: 
	<CAG17S_OaL_VK9e-s=DbwwKOAdjX9jR_B9ogifs9Di1-VW=ksmQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Keith,

On Tue, 2023-02-28 at 21:26 -0600, KeithG wrote:
> I am playing with ap mode and I previously used this page to set it
> up:
> https://iwd.wiki.kernel.org/ap_mode
> Now, when I use iwd 2.3, I get
> "Operation failed"
> when I use the iwctl ap start or start-profile command.
> when I revert to version 1.28, it starts to work again.  Is there a
> changed parameter in the main.conf or something that I do not have
> set
> right?

Indeed AP mode has changed in recent releases to support HT. The logic
now tries to pick the highest channel width possible, and in theory
enable higher throughput.

But perhaps some hardware doesn't like this, or the logic is wrong. For
the time being you can set this in the AP profile (with upstream IWD).

[General]
DisableHT=true

But if you could also send an iwmon/debug log of the problem I can take
a look. Make sure you start iwmon before IWD starts so I can see the
advertised hardware capabilities.

Thanks,
James

> 
> Keith
> 


