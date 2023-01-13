Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6EE2F2A
	for <iwd@lists.linux.dev>; Fri, 13 Jan 2023 15:28:35 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id r2-20020a9d7cc2000000b006718a7f7fbaso12419241otn.2
        for <iwd@lists.linux.dev>; Fri, 13 Jan 2023 07:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y2tl5hGe4jtMP7uEWVCbzz9NKuAYRsijRO+otm5ACDM=;
        b=poQ10L3tJz/ppp1h1C2T9g1Rz5TIozZ01grhrC7GzYRC0fEcNCk+S0KTpm6r5XF3Pt
         pu4uonKcobFnZshlTunBloYGOXMVk/l4W3zCMG9FWpo0EzdkMZqBx6W0KwhMY/31AkKf
         4nbbjDw5eIsltthz2RY/u3lJH1mvrp6QcjYrfAVMCBrCKyA4ORaoIx6da+lWO1MKaCfz
         B5U9SrAwhFOMQef1/tIyXo0iYUAng+wNtNxMYmbqj08u5gCnmtQ7ajuWuL1wxE7KOjxn
         l1pQ8XU5eDS45gKyKPO27Co2/PXZ5gypSdrO0401nmNUddwlJqDv9vnICTxtfmV84j3D
         VExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2tl5hGe4jtMP7uEWVCbzz9NKuAYRsijRO+otm5ACDM=;
        b=hOakHGmGGn8w3/Ccpx5SH/sXD5vPTkt9RdAoO6Xn3h4sTShTs8QFeZrQmmVxLwuaUT
         5Xt0PsSopg/A4jPYv7Vt0HkqwF/SBIx8HJKko4IU2DIxe4sxcTW6u19kfKPsdQ6MkQNY
         EAjAodMXarnHIrvwL6lRFSY/5zU+54Qw6tiDz40gClFgiqV+vF0uXgD9g3Ox1puwQ4hW
         5cumWs0aUHMDS1NMlaVYyT0Cb4N5HT/R1a+Xqn/4YrFCJcvdRbIL/rUv7gOil98wGH2K
         2/AGETlmGKflw+r0DaKUwoUmYyi5udlBpYm4oFm/EZJZRh3excomJ5/MXeKHnRf9xm5v
         7W7g==
X-Gm-Message-State: AFqh2krjuYD0thLIxMkfz0oILY++Y9BkfQ/0vyeiw3wL478UUa7b1Yvf
	UjT0Gr1kJqOG1wyX0Y9FcidkX6c3sb4=
X-Google-Smtp-Source: AMrXdXsL5fBX17RxdLJaczxVkPf4pk46COhBgqlY1g00zQ+3l+ayCFW1ZZBis3qFGJ1PK6MEehi/Pw==
X-Received: by 2002:a9d:688:0:b0:684:da63:a710 with SMTP id 8-20020a9d0688000000b00684da63a710mr365592otx.4.1673623714620;
        Fri, 13 Jan 2023 07:28:34 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id v26-20020a9d605a000000b0066eab2ec808sm10614441otj.1.2023.01.13.07.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 07:28:33 -0800 (PST)
Message-ID: <b391a2b6-4caa-2df0-97f9-0b4026018a67@gmail.com>
Date: Fri, 13 Jan 2023 09:19:15 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/4] doc: Document RekeyTimeout for AP profiles
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230112193212.568476-1-prestwoj@gmail.com>
 <20230112193212.568476-4-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230112193212.568476-4-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 1/12/23 13:32, James Prestwood wrote:
> ---
>   src/iwd.ap.rst | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/src/iwd.ap.rst b/src/iwd.ap.rst
> index 823aba99..ce402f91 100644
> --- a/src/iwd.ap.rst
> +++ b/src/iwd.ap.rst
> @@ -67,6 +67,13 @@ The group ``[General]`` contains general AP configuration.
>          ensure the country is set, and that the desired frequency/channel is
>          unrestricted.
>   
> +   * - RekeyTimeout
> +     - Timeout for PTK rekeys (seconds)
> +
> +       The time interval at which the AP starts a rekey for a given station. If
> +       not provided a default value of 600 seconds is used. A value of 0 will
> +       disable PTK rekeys completely.

So the default should be 0 (disabled).  Many older Linux kernels can't support 
pairwise rekeys without (the potential) for leaking cleartext packets during the 
process.  iwd checks for the presence of NL80211_EXT_FEATURE_CAN_REPLACE_PTK0. 
If the driver isn't capable of this, we actually disconnect when the 
Authenticator requests a rekey.

> +
>   Network Authentication Settings
>   -------------------------------
>   

Regards,
-Denis
