Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE026107B1
	for <iwd@lists.linux.dev>; Mon,  5 Dec 2022 19:01:28 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id jn7so11698170plb.13
        for <iwd@lists.linux.dev>; Mon, 05 Dec 2022 11:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OwJn6gzUqrN3ugpNGcQASWf2XWsiJZa+3u5oJFIuoyc=;
        b=UioXjXjsQTmZ6WLL6ZdwZzrHq60oowLQnVCwgO95fmaoSLsVNNHmM5rJ0e6DjFMVuc
         RD87ielXTCKJ/xo92PzmbtbIGalWapqzMv7dmBOruZ+QImwsOz1LLj6q86xLkHnSD4M9
         v+Ays9Yj2GWGhVCHm4hcxJ0AAW4NYo/0lWPSbd7rLU3m/eXvk35GkjxFYHGJNsSZ4cBK
         SFXOW4xOshkobeGOs6EzHUzdqXyUCLO8ITDdXLnaI/ntrE/H3LGQHXrPOEZy5+qx45F2
         7EpviNJxCkm9eMChSNByo6gZFQ68fcT56wZTUBYFdXNSc8SE8W5TDl6I15Dx1ISd1MbY
         4LlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OwJn6gzUqrN3ugpNGcQASWf2XWsiJZa+3u5oJFIuoyc=;
        b=jNl0s00O+hIP1a/zxNaJyNlFnexwUGDplp6A/N6j8YOWYjmgWojmdghhc4yfqofsfj
         fxlURxDsDt7sDYnGm79xXdGgpEyJ+ilWhTIZUTWh3EFOJ9/De/QdUDqlHGb2zNu5fU8v
         lQHux/UJT+Mv09df3gv4F2odFTnZqIkfUku4Ho8tSKt8JFJMTW9LTylzMasuKV+KL6L7
         7r+HbA1uG40rpFTue9YD5kfGNiq0rAgMJuWROwyixNUI2W0bGPl9SFqGB+QPKNak6YrP
         84wyWOiPGsjFAIH28jRcA48eGKiY5DylWLuXQ946wuJSi5or6k3gXg+DcJUdhzkEXxNB
         AwVg==
X-Gm-Message-State: ANoB5pmiHisRPQCU/eAFFPCA2qOinSczuA5geVhCi1FKi3V+fX/xpGiB
	sALncDsNZ5K2O9Sx6TnvaBKdmRDQrCg=
X-Google-Smtp-Source: AA0mqf4+26iNv4TzshCbZyI1I02mB9Js+bsDE1HPS/J3y9n3ek82WjuC1NPOi/51r6qsUnQrbFMkUg==
X-Received: by 2002:a17:902:b20c:b0:189:1318:714 with SMTP id t12-20020a170902b20c00b0018913180714mr78742252plr.122.1670266887349;
        Mon, 05 Dec 2022 11:01:27 -0800 (PST)
Received: from [192.168.254.17] ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id pa3-20020a17090b264300b0021870b2c7absm9483347pjb.42.2022.12.05.11.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 11:01:26 -0800 (PST)
Message-ID: <6c0e45693e254dd8dda4d07a51896bab855a6324.camel@gmail.com>
Subject: Re: WPA3 SAE passphrase limitation
From: James Prestwood <prestwoj@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>, Emil Velikov
 <emil.l.velikov@gmail.com>
Cc: iwd@lists.linux.dev
Date: Mon, 05 Dec 2022 11:01:26 -0800
In-Reply-To: <37ab408f-c9e6-7e9b-0088-d7e5fed08241@gmail.com>
References: 
	<CACvgo51HZVDcmvHiaZK3XFJyp6LUGRFEM+G=5j1--av=XWni+w@mail.gmail.com>
	 <d2df3b8c-2b0e-b587-bd04-4892e4e84f5c@gmail.com>
	 <CACvgo53tii9sLJFcmsPymJ-8HBZjvwpuBR4DNKYLNVdoGFY3_Q@mail.gmail.com>
	 <37ab408f-c9e6-7e9b-0088-d7e5fed08241@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2022-12-05 at 12:48 -0600, Denis Kenzior wrote:
> Hi Emil,
> 
> On 12/5/22 11:44, Emil Velikov wrote:
> > On Mon, 5 Dec 2022 at 16:58, Denis Kenzior <denkenz@gmail.com>
> > wrote:
> > > 
> > > Hi Emil,
> > > 
> > > On 12/5/22 10:19, Emil Velikov wrote:
> > > > Greetings list,
> > > > 
> > > > I was playing around with a router using WPA3 Personal (only) +
> > > > CCMP-128 (AES) and noticed something odd. Namely: the 8
> > > > character
> > > > limitation imposed by WPA2 is enforced with WPA3/SAE.
> > > > 
> > > 
> > > What 8 character limitation?
> > > 
> > On all the routers that I've tried the WPA2-Personal passphrase
> > must
> > be at 8-64 characters long. Anything outside of that and the router
> > will refuse. Although I admit that I'm not aware if that's required
> > by
> > the spec or otherwise.
> > 
> 
> Right.  8-63 actually and it is mandated by 802.11.  The worst part
> is that for 
> some reason they mandated ASCII only as well.
> 
> In WPA2 the passphrase is only used to generate the PSK.  Hence
> 802.11 refers to 
> it as passphrase -> psk 'mapping'.
> 
> > On the other hand I can use a passphrase outside of that range with
> > WPA3 only routers.
> 
> This doesn't apply for WPA3 since the passphrase is used directly. 
> No need to 
> generate the PSK.
> 
> > 
> > > > Whenever I try to use such a passphrase (via iwctl) I get an
> > > > error
> > > > "Argument format is invalid".
> > > > 
> > > 
> > > Refer to crypto_passphrase_is_valid() for what we consider a
> > > valid passphrase.
> > > 
> > > > I realise it's not the best practice but the exact same router
> > > > just
> > > > works with my Android Pixel phone.
> > > > 
> > > > Would anyone be interested in fixing this bug? Alternatively
> > > > any
> > > > pointers where the validation happens would be appreciated.
> > > > 
> > > 
> > > What bug?  In theory the passphrase can be anything for SAE-only
> > > networks, but
> > > since there are plenty of cases where hybrid networks exist,
> > > managing separate
> > > SAE and non-SAE passphrases becomes tricky.
> > > 
> > 
> > Whenever I try to use short passphrases ("testing", "foobar" or
> > "foo123") with a WPA3 only network, IWD fails to connect as
> > mentioned
> > earlier. I don't have the spec to confirm, but this sounds like a
> > bug.
> 
> Just a design decision.  When we started WPA3 was still rather
> uncommon and 
> hybrid networks were (and probably still are) typical.  Since you
> want to roam 
> between WPA3/WPA2 access points, enforcing the same passphrase
> requirements made 
> sense.
> 
> > 
> > Can IWD detect if the network is WPA2+WPA3 or WPA3 only?
> 
> Not really.  You can have a network composed of WPA3-only, WPA2-only
> or 
> WPA2/WPA3 hybrid APs.
> 
> About the only thing we can do is 'assume' WPA3 when:
> 1. The user entered a non-conforming passphrase, and
> 2. The current connection candidate is a WPA3-only AP,
> 3. Connection succeeded

There is also the case of network profiles which we know even less
about compared to agent requests. We could allow <8 character
passphrases and just force WPA3 for these profiles too... but its still
a rather weird side effect having a short passphrase force WPA3.

> 
> We'd then need to make sure to set the WPA2 transition disabled flag
> and make 
> sure we don't try to generate / or save a PSK.  The transition
> disabled 
> indication would make sure we can't connect to WPA2 APs in the same
> network.
> 
> > 
> > It so, would it make sense to omit the `passphrase_len < 8 ||
> > passphrase_len > 63` restriction in crypto_passphrase_is_valid()
> > when
> > the network is in WPA3 only case?
> > 
> 
> See above.  It is not that simple, but can be done.
> 
> Regards,
> -Denis
> 


