Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36BD192B62
	for <iwd@lists.linux.dev>; Thu, 29 Aug 2024 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724931921; cv=none; b=nNOFrhH3O4yB5h4hWDowAXkEVsOp0d56kGjF0KLMRZmYFVLJNcTeydYwa4PuNwfjmUy0ZoWCy+smrzKlOSk+aHoGz+qho+TuTEsejOoBJPjUm6sb1HA6mkWF+2qsptD6UAmiZlFPoHk+33tWf4uG4EsY/R4sfygdNFjdUOG2SM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724931921; c=relaxed/simple;
	bh=Tu4e1Xnud8Jveflffe3r0NA8QCCSAA/wA9qWWMFH7n0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OgCDzCoEc2RSziWfXE09zmhb+LcVP7wTkpZ7C3v6xZJuyqPVy2AS1snhcbyfyulwxuA4Ljb1cU67dJhmm6OAoDdwVd6lBrWrKoOyA2PCs0kb6dc0Nl8ArbDNtClCqup/A7QJfJqb2f9VTHmvXyAqKU26kki1dZDC56tqhLAZsyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScwW8pKv; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScwW8pKv"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7cd895682fcso201938a12.0
        for <iwd@lists.linux.dev>; Thu, 29 Aug 2024 04:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724931919; x=1725536719; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZfqTx/qajgymgWBBDUUfA6nZWs5SqIBy+Xyy8+vOiac=;
        b=ScwW8pKvDPdpFSK7bCa95XyhvsYmP1OGwmAKbmK4JB175N+qqcCkUt9PwVhbo7XXfV
         A/hWHmlN1a3zGqROSAtGtOdi6JvV+q5OObqNL+7cQJefKgiDueXy/fVOX5rWUbUu6gYw
         7y/y43dPHPG4xocJJzO8rJnm7wYtG1+xFqx+Eg7/zMYbe1K6QZFcypHlZ2+ySglzVZER
         eni291pbLOS/w50Kv3BVeememwyj0pcamDLAgHdW7Vdtpr1POPSMTrBwb6u+kNHGyTg6
         dJuvarNahPOFk26vghbcfFgmtDdv1vCxHS46IbzEbff4uI1CZDVv8y5IqpAF1r5a/JWe
         2uqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724931919; x=1725536719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfqTx/qajgymgWBBDUUfA6nZWs5SqIBy+Xyy8+vOiac=;
        b=QPdhZo9gIKzHDMreXRP7ThX+Pgl+ueixWATmk5iixxSvSzqzhUr96VLCKswSJh6Mmp
         RDw1v0Xb7ZA/BdvLEh6/KWhMQO1LJ9MSSWJhKRSgt74qdxlyJKV1n9Wy2geRXKE72aXe
         2Jcf2nGgbTS3aPNBK8Z73b+G+TlmdpXPh9md79iup8RT+R3CCd+hpwRrgkreCg32WYD1
         7MU5FionO/Tg4qhf54CMqiUs529zxq/Gyobbc6M5Fgqgfo3iDzpVHHsDMAX/JNWqw5s/
         /33yNRPOzkOnLberifG807Wn7Y8Oxok5hIJ/nrjmkHhyOeoVVAvFAb4UPDhw0nUaOj6X
         9ABQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5rB0fKKsC0jbxGjo5mdPQvuKSIKFXv5xINliBpgn/eb3KlEAbM4wfmIauNtaki8sYBxg=@lists.linux.dev
X-Gm-Message-State: AOJu0YwDO1UVIAE0ab27iAm+zcCKSDnqtlZuiaN9HN1rViYAJI/rHYEn
	JAPsja7+olarwQR+XUN2UFuh0tOsOIG4qMALkTc8cbxTf0OwUow8QTEUyA==
X-Google-Smtp-Source: AGHT+IGGo015P9MoXTsibb6iSL9QGY97LmsRoXdx0f4YHpJyvZYEkWAlfm4hq+OQ3OK9W0W4JBKtDA==
X-Received: by 2002:a17:90a:f18b:b0:2c9:75fd:298a with SMTP id 98e67ed59e1d1-2d8564e3835mr2302491a91.42.1724931918996;
        Thu, 29 Aug 2024 04:45:18 -0700 (PDT)
Received: from [192.168.1.164] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d85b3b9522sm1348682a91.50.2024.08.29.04.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 04:45:18 -0700 (PDT)
Message-ID: <eaa91b3f-b8af-4c6a-bf40-6613d80d4ff5@gmail.com>
Date: Thu, 29 Aug 2024 04:45:17 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Build failure with GCC 14
To: bbhtt.zn0i8@slmail.me, iwd@lists.linux.dev
References: <520f3ed2-79fe-4b91-9442-b219cb00732a@slmail.me>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <520f3ed2-79fe-4b91-9442-b219cb00732a@slmail.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 8/28/24 9:13 PM, bbhtt wrote:
> Hello I'm seeing a few build failures when building with GCC 14. Not 
> sure what would be the place to report these.
>
> ```
> monitor/main.c: In function ‘genl_lookup’:
> monitor/main.c:328:30: error: passing argument 2 of ‘l_netlink_send’ 
> makes pointer from integer without a cast [-Wint-conversion]
>   328 |         l_netlink_send(genl, GENL_ID_CTRL, 0, buf, sizeof(buf),
>       |                              ^~~~~~~~~~~~
>       |                              |
>       |                              int
> In file included from ./ell/ell.h:17,
>                  from monitor/main.c:43:
> ./ell/netlink.h:34:59: note: expected ‘struct l_netlink_message *’ but 
> argument is of type ‘int’
>    34 |                                 struct l_netlink_message 
> *message,
>       | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
> monitor/main.c:328:52: error: passing argument 5 of ‘l_netlink_send’ 
> makes pointer from integer without a cast [-Wint-conversion]
>   328 |         l_netlink_send(genl, GENL_ID_CTRL, 0, buf, sizeof(buf),
>       | ^~~~~~~~~~~
>       |                                                    |
>       |                                                    long 
> unsigned int
> ./ell/netlink.h:37:58: note: expected ‘l_netlink_destroy_func_t’ {aka 
> ‘void (*)(void *)’} but argument is of type ‘long unsigned int’
>    37 |                                 l_netlink_destroy_func_t 
> destroy);
>       | ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
> monitor/main.c:328:9: error: too many arguments to function 
> ‘l_netlink_send’
>   328 |         l_netlink_send(genl, GENL_ID_CTRL, 0, buf, sizeof(buf),
>       |         ^~~~~~~~~~~~~~
> ./ell/netlink.h:33:14: note: declared here
>    33 | unsigned int l_netlink_send(struct l_netlink *netlink,
> ```
>
> Thanks!

Looks like you just need to use a compatible ELL and IWD version. When 
APIs change or are added in ELL and IWD depends on that we do a new 
release for both. We don't really have a table explaining compatible 
version, which we probably should.

Thanks,

James

