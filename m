Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B22749C
	for <iwd@lists.linux.dev>; Thu,  3 Nov 2022 16:03:42 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so2248271pjk.1
        for <iwd@lists.linux.dev>; Thu, 03 Nov 2022 09:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=buTuFc7u4fQ6o1kMClgF55jjTXbB0pcbzs7nF06V1C8=;
        b=bPHlgAq27U5rMbZ8jGvyMHFYg3Qje2IUZhjKwZkxLSAg/YQbRW5bJx6+GRTw6kGBJb
         rs8WSbuwS3L6sIJh7BmGFT0NzvF73bfsC7f/tBc0VzZgo2e8lbyCtbp+C6mMJl3JaMMD
         Ne7onhyDRg9W6C0B9adz0zqgyeneeB6mONaDLW17qYt+HUPrPNILeIkwNpacxDVRe1jT
         ZthJ0qkWarUJtY/xLtl9HKez+5R8Tt8POtsOmzP6s8ux2BdwP3Rwqtb5A8O31VXI1WR1
         Hn14HZZtzj1TKnrrxM3NKWzoMFdHPpsx+CVRy8kfSwg9h5iOy6EuGXwqc/mpmI5yPIsB
         QBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=buTuFc7u4fQ6o1kMClgF55jjTXbB0pcbzs7nF06V1C8=;
        b=fCvjVn5FDuf/BQTE4HYWUNibpRCCu2w0bdH06HOlSTTcS27i0LqIwyRovuNEvIf/X+
         ilhus1FUZA9eg57Ep+JcvVrZVqKP4GxlfCmC8vBI88k5tL9F2+3yO7kVPiG633WSK4jb
         HGBBzLF0NUDdKfeiVpat1XpoenWdxCWybZ512PnOxL8VLpE7/J3IjhHWsXXbH78Sdcc3
         jN03BQwzeY+N6S8VYMfSse4q1xZceeohnja1jmR2WbOp1+IBdfmjJy182xviQV7OkpM1
         3XvvrojD7YRSYahl15XVsZ3WkuRUC6fhHjBNKIXYsMR6hnDFrAQ3QJSvPZIsTGJA8eLY
         XC6w==
X-Gm-Message-State: ACrzQf1YLvk0+H1lTfm2RwezIi7NNkSrbxCemTtal9LYt6jIsiRu5qD4
	mQYgmwfQzfh0/PLApm2dy/I=
X-Google-Smtp-Source: AMsMyM7/roSfl783SWvC0DXtwYaH+bmS/O22pBaQenLyuuFDrhDUKI8umcY/iTceQctMtuo4IM2+eg==
X-Received: by 2002:a17:902:edd5:b0:187:1e83:8b96 with SMTP id q21-20020a170902edd500b001871e838b96mr22691092plk.1.1667491421773;
        Thu, 03 Nov 2022 09:03:41 -0700 (PDT)
Received: from [192.168.254.15] ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id i188-20020a6287c5000000b0056b818142a2sm915565pfe.109.2022.11.03.09.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 09:03:41 -0700 (PDT)
Message-ID: <a865b6744c84c46917bf523f40a273862019816a.camel@gmail.com>
Subject: Re: [PATCH 1/2] netconfig: add global MulticastDNS option
From: James Prestwood <prestwoj@gmail.com>
To: Rhys Perry <rhysperry111@gmail.com>, Andrea Pappacoda
 <andrea@pappacoda.it>
Cc: iwd@lists.linux.dev
Date: Thu, 03 Nov 2022 09:03:40 -0700
In-Reply-To: <CAGTBY+t3E9p44FPhJu9k5QuDX2EzdxV85ipscNFJFq3_xQBcDg@mail.gmail.com>
References: <20221103105639.8289-1-andrea@pappacoda.it>
	 <CAGTBY+uDse4b5KzLmVN1Xx5w6bnYAgzT+hO9GPxzavP-8UiHeA@mail.gmail.com>
	 <5X3SKR.2RJQXQUUD6QA@pappacoda.it>
	 <CAGTBY+t3E9p44FPhJu9k5QuDX2EzdxV85ipscNFJFq3_xQBcDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2022-11-03 at 15:56 +0000, Rhys Perry wrote:
> On Thu, 3 Nov 2022 at 15:48, Andrea Pappacoda <andrea@pappacoda.it>
> wrote:
> > 
> > Il giorno gio 3 nov 2022 alle 14:23:57 +00:00:00, Rhys Perry
> > <rhysperry111@gmail.com> ha scritto:
> > > Since we're getting a global setting for mDNS, would it make
> > > sense to
> > > add a global setting for DNS at the same time too?
> > 
> > I'm not sure about this. Setting a default system-wide DNS server
> > is
> > already possible by other means (by editing /etc/resolve.conf,
> > modifying systemd-resolved options, etc.).
> 
> This doesn't seem to work, as systemd-resolved will let the DNS
> server
> passed from IWD have precedence over its configured default server.
> systemd-resolved can take over /etc/resolve.conf (with its own stub)

Couldn't you set [Network].NameResolvingService=none in main.conf to
work around this?

> 
> > Also, overriding the DNS
> > server received via DHCP can create issues, and I wouldn't feel
> > comfortable in enabling such a setting for all of my networks.
> 
> Fair enough, although I feel some users like myself, who quite often
> connect to untrusted networks, would like the option to be able to
> avoid blindly trusting the DNS server provided through DHCP (without
> having to manually configure the setting for new networks they join
> and don't trust). I would certainly prefer to be able to set a global
> DNS, and then override that in the cases that it causes problems
> (e.g.
> captive portals).


