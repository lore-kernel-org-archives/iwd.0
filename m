Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F374401
	for <iwd@lists.linux.dev>; Fri, 26 Aug 2022 17:13:06 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id w13so1918655pgq.7
        for <iwd@lists.linux.dev>; Fri, 26 Aug 2022 10:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc;
        bh=IoyOHNm3N0mcBy0MGKLXnmHkm9Ij1JnemhXKaXFdhf0=;
        b=J1ror8TAcQuPLRqbgtmrJnSu5VVLERHToVhOIh+8b2GC+05ndsF+N0wa1B4evnXPwJ
         9C683BJlhYQtHfKgxhbmKaQnpwvIb59yEc0iFlUCjthpSa9i6wahYq76RZcZw0HQRDdO
         ImYAYbyT2L6oaok/xLJvUPoJqEVSAkluG7Jmz94xNF3tmQUOKXJWPlidlcbvpect6ua5
         zOw54F7IbIrwzPC7HA3Fw2SZm+cLMgfhUzXRifXWkU09feeMmEwfUzJlg1M011ZcaddG
         lbr9mvMgridnBMsdRDMxugUQVxKs2YyLFXT9R6HOdUwbp42OX8HlWu0UDCSwzqT8qBok
         Pj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc;
        bh=IoyOHNm3N0mcBy0MGKLXnmHkm9Ij1JnemhXKaXFdhf0=;
        b=DvjusQFyVvglSYqo+7lyfdlwVRbAew9wPNNkOWA/TCgjJMBr8VOec3HUQYzrPM/4MG
         Z15YK8e8hNH8JncvO3ZLMQhK7r+DEPtEEJo0+RM+ceOOP8O1LGPRhf8bDsfV30atd2kU
         i+Wt7vkiU5XY377BYzKHVz3/X6nO1hxrWos8lFpefAZTGHM58svp4yoo03JO0HaIIinl
         +lX3OafHQb2hs627js+CPO6/b/bPwP8WJpJnNmTYRXC53vNMm/Xr7CbJIU7kl3UXREao
         IhZ3cQv0hsfrVOtuJGlolPPBxqEU3qKhZ5XBf2HLRc0zdypbeVc7QUw+kH/lNOuyqSYO
         vj9w==
X-Gm-Message-State: ACgBeo2Jyk1Lx6rVUkbPBTsjpY4KrvZ3hGwefwJgXxX0/RDEDYjZKrEE
	P0Q2F1geC3H+Xk6fDQDNfHw=
X-Google-Smtp-Source: AA6agR69m6RqVpWHlmKWG+sBw5Pab4YOioFSDScpD+6MkBcXHD2ldSSyF+SRdiKsjxGAjAyJYVFhIg==
X-Received: by 2002:a05:6a00:ac6:b0:530:3197:48b6 with SMTP id c6-20020a056a000ac600b00530319748b6mr4843124pfl.80.1661533986112;
        Fri, 26 Aug 2022 10:13:06 -0700 (PDT)
Received: from [192.168.254.16] ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902ecc500b0016d93c84049sm1859828plh.54.2022.08.26.10.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 10:13:05 -0700 (PDT)
Message-ID: <d37780984424a813a9d7bf38388cf030937c08b8.camel@gmail.com>
Subject: Re: Trouble with arm64 Pinebook Pro
From: James Prestwood <prestwoj@gmail.com>
To: bakerk98 <bakerk98@proton.me>, "iwd@lists.linux.dev"
 <iwd@lists.linux.dev>
Date: Fri, 26 Aug 2022 10:13:05 -0700
In-Reply-To: <PTsiuiJUXgqE6WrNOYd6ijGXJVXO02MieWUrljZMKnDS9yvx1-HPGE_-SmsmhHSeSqmW_BNe5WHhrKeDLVxUAcFtkY8cfbI6GLiVMYLwZLI=@proton.me>
References: 
	<PTsiuiJUXgqE6WrNOYd6ijGXJVXO02MieWUrljZMKnDS9yvx1-HPGE_-SmsmhHSeSqmW_BNe5WHhrKeDLVxUAcFtkY8cfbI6GLiVMYLwZLI=@proton.me>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Fri, 2022-08-26 at 14:01 +0000, bakerk98 wrote:
> 
> Hello,
> 
> I am having an issue with iwd on my Pinebook Pro not recognizing the
> kernel config completely. I have configured CONFIG_CRYTPO_MD4 and
> CONFIG_DH_KEY_OPERATIONS as Y in my kernel, but I am getting errors
> through iwd specifying that features related to those 2 options, such
> as using MSCHAPV2 are disabled. iwd then recommends that I enable them
> in my kernel, but I have since verified and recompiled my kernel a
> couple of times with no luck.
> 
> Any help is greatly appreciated, and if I can include any extra
> information I would be glad to.

Don't blindly run this script but this should contain all the options
you need if you want to cross check:

https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/tools/test_runner_kernel_config

I say don't run it because its meant for a KVM/UML kernel so there is
stuff in there for the regulatorydb, and other options which a bare
metal system probably shouldn't set.

Also, make sure to check the .config *after* you build. Sometimes
options get disabled even if you say 'Y' to them due to dependencies
not being met.

Thanks,
James

> Thanks
> 


