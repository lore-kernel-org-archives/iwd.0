Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604671360
	for <iwd@lists.linux.dev>; Fri,  3 Nov 2023 02:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZFKLWi6"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ce2cc39d12so869838a34.1
        for <iwd@lists.linux.dev>; Thu, 02 Nov 2023 19:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698977356; x=1699582156; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cNj4+JJB1/ITigeR4/5gm3+03I88lFwHfBJCUJfHOfk=;
        b=TZFKLWi6IFeEKSF8jyXyu+CqOh9JMdQQuSNaNpRZYKqrmSTpLIohLTSD6w4jFaDifU
         JoHOmI3Z+SKtgSMeAEMOwadZKSLTr6vAHR8FMOjXlEq78ky/NSBpJGdVItxWpbBkyZ8+
         Fg9uPBUKlRZGw7RhDZoK6402UlXbqi+6mIJuwC54AMqPhTieLG50NfWFvLO4JD5Pnafa
         xvIQ2HBh0UaCdxa72dV25ssJsCzNGY+VEaRkK81Cq+AN8cPjIBI/7p3gShXaADOTtJj9
         PqAueKQ9r2Oz4r+lMkThxo+SO0XxFRRf/IzPZyFPaNPaUnSuV3y9UZhCkSsOAmAIZeqg
         FtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698977356; x=1699582156;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cNj4+JJB1/ITigeR4/5gm3+03I88lFwHfBJCUJfHOfk=;
        b=bAaJOeleowdtvQmtmVW5hYQgDt/gohIpe6iILaKXojWaT+fVumOKs5Aj4z6E6lOhq6
         URO9IY8j4IgFcbRHII6HzLU4EutyonK+F2WVZYs8Ud2FOzXJubrgH2R4+7EPN1qTfbyU
         zHUFtvCAoO3u0PRFKNmMA9QW9j6GFCLCVF7PQsU5Mvlr3TDyBUcwwQTSobdEVfCAhwg7
         wp9RsJc81YE0z4jeYJoBHeBZIM6jBLfQX2fMktmALBPSDKrlLY71ej9VJfjljhGpOkXa
         BFQPmOjtMdbNh7okzMQ8ilwDjAnvBQMiGZUXwluziT/rBU+FdyVImrfuav1MyU/+qV08
         36Gw==
X-Gm-Message-State: AOJu0YzYAlyGkORIsGzvK13+3tPYq8LWPXHMSZDoGq7M5ZFyYawxwCf7
	vGYU4B+Qg67r3hhjarQrP/0=
X-Google-Smtp-Source: AGHT+IF9EuXDa4iiOKLzDudiUQdf46ndfo2waHc27dWRR1Z0BGvUrGfVXQDyDK/cdQH4paii7ElMPg==
X-Received: by 2002:a9d:7d89:0:b0:6bc:63c9:7946 with SMTP id j9-20020a9d7d89000000b006bc63c97946mr21035049otn.14.1698977356440;
        Thu, 02 Nov 2023 19:09:16 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bd19-20020a056830359300b006c7c1868b05sm140430otb.50.2023.11.02.19.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 19:09:16 -0700 (PDT)
Message-ID: <b43ccba6-e9f7-4332-8a9e-c4fc4e535cf5@gmail.com>
Date: Thu, 2 Nov 2023 21:09:15 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] dpp: SharedCode interface,
 {Register,Unregister}SharedCodeAgent
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231031184750.722404-1-prestwoj@gmail.com>
 <20231031184750.722404-8-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231031184750.722404-8-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/31/23 13:47, James Prestwood wrote:
> This adds the SharedCodeDeviceProvisioning interface as well as
> the two agent methods. After the PKEX configurator role is added
> it will need this to request a shared code from a registered agent.
> ---
>   src/dpp.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 100 insertions(+)
> 

<snip>

> @@ -354,6 +373,11 @@ static void dpp_free(struct dpp_sm *dpp)
>   		dpp->boot_private = NULL;
>   	}
>   
> +	if (dpp->agent) {

Call Release()?

> +		pkex_agent_free(dpp->agent);
> +		dpp->agent = NULL;
> +	}
> +
>   	l_free(dpp);
>   }
>   

Regards,
-Denis

