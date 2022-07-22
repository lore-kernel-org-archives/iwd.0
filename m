Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F0B4A2C
	for <iwd@lists.linux.dev>; Fri, 22 Jul 2022 18:19:25 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id l14-20020a17090a72ce00b001f20ed3c55dso4874497pjk.5
        for <iwd@lists.linux.dev>; Fri, 22 Jul 2022 11:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=tlVIra6L3/c/vZuzQws9VpYvzRMKXFOyk1GS+pwGesc=;
        b=EJSFhq1+xXbAxKUhmTtOt5iSYM2Fc2Fn5V5JRkhXi/peA25fgw+FTnXvs60Uec6VtU
         brcIeF5JeFYImC7kniVHR+vzkbpOJeTsMkGKnyRMn+c3EzBG1UfhW/GYIj7pA9n+dxnk
         h7Q14cyGXlpxBQEt/OoVlH/eqeocU6NF9wyZrD9eackje4b40/OEcoaWd/cP/mebkiHt
         MJ7NEEIDSzZIMarNUKQBJ7hvc8x7Er+uDbgLXA+R9hVryDIlaLhB8HVjpPt10JwtvNSG
         KBTFODC58E/OfRhdjb4OTgaBomJM2Gv65yR8AIH0dfZU+cS4W55xZwdG8ykbZeGGZSSm
         3+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=tlVIra6L3/c/vZuzQws9VpYvzRMKXFOyk1GS+pwGesc=;
        b=DzCMMxLaXfwbIo9kuGr+yTsvBtD7StGUuiiv9sqFhWWd/l1EQ68VmSMszncfO7CNyh
         tk9yaV1vxpllJlgw8bajDBJTO8RlHa0miEuKxnne4ijbzjazQhPkJLNx/HASjjYtNcvb
         DSPPd56WDn0Di5uTvoglcQCHl2FYFR4avSxV+DtBCiplkpmcMD28FU4+AL4ZE0LoUy6g
         f4BE1Mvz6DCq15Fl4nRbVXxvJXDKMBXZD4EzrtBFpG8n9cw2T/+Cl7vNDVJqYWVMUreZ
         GlryE3hw6OJTyFwUM00X8eO70hj5mX1dfT0U0ZBOcznxPNgg1yXXcDRa0ZtczNnHk7ux
         pSgw==
X-Gm-Message-State: AJIora+oQRUwHNjzcSXVT8ATSizedPW51UUFWyX6JlJGb8NY87cWEvmJ
	gSA7eKxMi/B6gIlZN1Gs0Z8AuHU9B70=
X-Google-Smtp-Source: AGRyM1uXN8Cs8EY93qHlj47Qri6m5qLek8TpJ5EebIIAvxascZ/y65srRkZPinG57t5rEx/pRodp6w==
X-Received: by 2002:a17:902:76c8:b0:16c:1c13:9eea with SMTP id j8-20020a17090276c800b0016c1c139eeamr1041286plt.83.1658513964817;
        Fri, 22 Jul 2022 11:19:24 -0700 (PDT)
Received: from [192.168.254.55] ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id x2-20020aa79a42000000b0052ab42ea0c5sm4419545pfj.147.2022.07.22.11.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 11:19:24 -0700 (PDT)
Message-ID: <a866778ba1ac2eef9434e3f9027fd54e63b134bf.camel@gmail.com>
Subject: Re: [PATCH 4/7] util: add scan_freq_set_max
From: James Prestwood <prestwoj@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
Date: Fri, 22 Jul 2022 11:19:23 -0700
In-Reply-To: <7a6cc538-2ed4-b464-84c7-e7a92a3cb170@gmail.com>
References: <20220722163417.1119334-1-prestwoj@gmail.com>
	 <20220722163417.1119334-4-prestwoj@gmail.com>
	 <7a6cc538-2ed4-b464-84c7-e7a92a3cb170@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-3.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2022-07-22 at 12:41 -0500, Denis Kenzior wrote:
> Hi James,
> 
> On 7/22/22 11:34, James Prestwood wrote:
> > Finds the maximum frequency in the set
> > ---
> >   src/util.c | 19 +++++++++++++++++++
> >   src/util.h |  1 +
> >   2 files changed, 20 insertions(+)
> > 
> 
> Do you really need this, or is scan_freq_set_get_bands() enough?

I think so, because if some known frequency is in the 6G band but not
even supported (e.g. if the card changes) we shouldn't bother doing the
full scan. Somewhat of a corner case though.

> 
> Regards,
> -Denis
> 


