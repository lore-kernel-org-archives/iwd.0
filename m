Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D962F36
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 18:50:54 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id y203so3071788pfb.4
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 11:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1I35uGjVRWTYrh82MyMq9N1qpvFtkO9/bvnN3zAMBSw=;
        b=THpEtmZYuJdN5VI3aWnYDr/XAGxLPy2nDW3jopdkI3KyqPPHcccpJzDezhhN+96+dl
         dKW0V6rwOi3Q6Zql4hhE9JxL40XuUtD8dbAwClh5GwOzRDmmkTH9zjUU3Oj79+QwzlzD
         7unrv90ussgH5/9iIXYjVAye/iHi3iOq2oBs7ft91OUEHTNGPvd+PJzTgUniSjpXoS9D
         adEATS+OVPW9Rzinmznu/GRLByIj4PS7jn/k7Q1PdPTEaFQvrLRRDiaUBDDthG2mupct
         BW0H6itNY5FPrHSwnxMJxTSlxj8GQoEotkWQqwtevaptkCi3qk5AZPxe52MC1BngwKrF
         uXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1I35uGjVRWTYrh82MyMq9N1qpvFtkO9/bvnN3zAMBSw=;
        b=cjnS6U2XIQbMjIxMJGjohIjBXayv+R+taFwqhED7meP433CyWUXWx4DpsIEqoATsgK
         D5x4/WliIiAXEnOpkkbNxTY+8GbFuKXEwCqtque+NXECYZDHbSzH5FtsheM1pwr6Nd7H
         LEa7jn1zJoogCSv8+ot+bTsFYaAMWvV+CA6S0OPddgNSqeQcdVjL9mLuuOHqZV3kHYM4
         XH3cyT9ImtLIcjuMoeYs+z9larjNPN06X+0qBSLrPWw7CBaoSwV2lygostkknm0c1JGc
         JY+gYTNEseTD8Ofo353uUy9JYbfyW8Hv4tfQtqeMf9ccAx0FkHPsA77c5HlGyMxAWRkb
         cuLQ==
X-Gm-Message-State: ACrzQf2KVCOlZqMyoYZS5gEeD+Wf35oOSYL/Lp7uwrSX9Pfpv/r+LWtk
	cergnGML15pwUSG7T9NHiJz36aF5K0E=
X-Google-Smtp-Source: AMsMyM5pt5nQztiC2Us0OidxbANwnNxp2bRi1eCM4SnakMYonkInfScN9ZrUuMWe0weuqIgj6KlrWg==
X-Received: by 2002:a65:6cc4:0:b0:412:35fa:5bce with SMTP id g4-20020a656cc4000000b0041235fa5bcemr22534880pgw.466.1667415054087;
        Wed, 02 Nov 2022 11:50:54 -0700 (PDT)
Received: from [192.168.254.15] ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id s1-20020a170903200100b001782398648dsm8674418pla.8.2022.11.02.11.50.53
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:50:53 -0700 (PDT)
Message-ID: <99e42ccbadbba35899cb85d4dad7943983a587d0.camel@gmail.com>
Subject: Re: [PATCH] json: update internal type definition to match JSMN
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Date: Wed, 02 Nov 2022 11:50:53 -0700
In-Reply-To: <20221102184600.230988-1-prestwoj@gmail.com>
References: <20221102184600.230988-1-prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2022-11-02 at 11:46 -0700, James Prestwood wrote:
> Fixes: ceda955ba7 ("shared: Update JSMN to latest version")
> ---
>  src/json.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/src/json.h b/src/json.h
> index c6220667..8cf2ba03 100644
> --- a/src/json.h
> +++ b/src/json.h
> @@ -27,10 +27,10 @@ struct json_iter;
>   */
>  enum json_type {
>         JSON_UNDEFINED = 0,
> -       JSON_OBJECT = 1,
> -       JSON_ARRAY = 2,
> -       JSON_STRING = 3,
> -       JSON_PRIMITIVE = 4
> +       JSON_OBJECT = 1 << 0,
> +       JSON_ARRAY = 1 << 1,
> +       JSON_STRING = 1 << 2,
> +       JSON_PRIMITIVE = 1 << 4,

Whoops, this should be 1 << 3. I can send v2 or just fix this up when
applying?

>  };
>  
>  enum json_flag {


