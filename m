Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1BD7A
	for <iwd@lists.linux.dev>; Wed, 29 Jun 2022 18:37:54 +0000 (UTC)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-fe023ab520so22562390fac.10
        for <iwd@lists.linux.dev>; Wed, 29 Jun 2022 11:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=OJ40JhU6QnX2h5X+lxldJOYgHh//MzQmiA9d2m2V3jM=;
        b=MlAXuK5o1Ncgcx5H8s3dTmNoFo7tMBAYh2QFoq+ZUjDa7K/AwSe8MoIYlIulP79YEQ
         QVWRE17JJBZ7ZVrrn/GRMBBPc43TNVPPApJodU7i1jecKSkcVOq8vGFzGN2rp33fXb35
         4vGYJnPXoI9vdf1lxibNvFCVIRdAguHn1hULqR5P1UyPVlSO6yOo8OWbxTS1yaDl2kX2
         Rx5uRQIw4hO4B2MqAAXlZzvgDtbXtSZ8pqSNz/0mA6YefiNQWp/aeJXWQeMy5izAVU9L
         TeJAy7+C+jM9nuDgCpX/E/C599YjHd7Oqr2fJ7Qh/gLFW2tBic2cjebQzb9MGXzk8HVK
         37Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OJ40JhU6QnX2h5X+lxldJOYgHh//MzQmiA9d2m2V3jM=;
        b=7BVKoUvw96qbfUUL5SX3W+WVXGdXkm3uBwJNbcvHPrKzFJKaM89q/k351ihOjElLJn
         fPZ/T7MuBHb/XGHxHqbz2eUUbsF/wyeoLcx+IxQ2eCs2hR1jRQx/djKbxbpixS/3S4s7
         Hl3umBzfjVpIWele0ah92DoN4sPLLOAdO4r3gEe0uXgO5X3Em/iPxD9n/GHM2ir7/hVD
         Iqw3+h/TKkG0b/moFh+9+rCxIsw0lbdAGVI4+NkCunYmzXEmXvTo+VMi5FKPY/c0sd9z
         MrOc1Xh+eCSYgwGpPHqRxhVD2khrvxuVMmbEI3iosz0hN/D4IK4lagqgWbe26XBt8doa
         fGnw==
X-Gm-Message-State: AJIora8eqqijWHsF8eq4uBOmKj3boacGujslSfFRFvBXqIyCrKMK6HzL
	F3vrMUN+/G/UN/Hpq7cPksU=
X-Google-Smtp-Source: AGRyM1sTvBPbzo727k3LSiVdUGl6YwfqZuuxJF18Z6jkvZpiYV8WPgWlDgABrUvruozUXUtqR+5X9w==
X-Received: by 2002:a05:6870:d5a3:b0:f2:c923:682f with SMTP id u35-20020a056870d5a300b000f2c923682fmr2749827oao.120.1656527873876;
        Wed, 29 Jun 2022 11:37:53 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 127-20020aca0785000000b00334c2e81dfbsm1694797oih.0.2022.06.29.11.37.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 11:37:53 -0700 (PDT)
Message-ID: <538789c6-d9bf-c8ee-6371-d4e464741186@gmail.com>
Date: Wed, 29 Jun 2022 13:25:51 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 1/2] auto-t: allow multiple PSKAgent's to be registered
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220629173113.2442455-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220629173113.2442455-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 6/29/22 12:31, James Prestwood wrote:
> By creating a new bus connection for each agent we can register multiple
> with IWD. This did mean the agent interface needs to be unique for each
> agent (removing _agent_manager_if) as well as tracking multiple agents
> in a list.
> ---
>   autotests/util/iwd.py | 51 ++++++++++++++++++++-----------------------
>   1 file changed, 24 insertions(+), 27 deletions(-)
> 

Both applied, thanks.

Regards,
-Denis

