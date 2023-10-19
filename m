Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8582FE07
	for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 14:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgrdICFr"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3b2f2b9a176so956970b6e.0
        for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 07:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697726065; x=1698330865; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wjZ4qxx8eHlX52M396pyZosQWfD8ZyKpN5ePJA4neiE=;
        b=kgrdICFrTW6L6P0/vvZQpQDNQLMmL3JNwGrAvyHVPvoq5FVjEIpKbvVWztyhg/rn2a
         EgFal77euGy+aGNYPZeus6I8xRDz98Wkj0VdDNHjKC+j7vAT2uLgcaPfZmPXhUBpK4KS
         vmHzuY+Ou6c2OR2ET78p+j7IAzK4IcfoICXXapKwHyp2jFMsvLtyNs3B84k+55vfLMHs
         gq+L3mMNPuWd8n9GytToj2FjXaBNHLFcn3epCh9PJ1/NL0nh+dG8wQpfz0sTRB1j6s+G
         RrsLIP+RmDhCJD3dGRm7A9ImrbKqdhkzXDrbum5/ipSTh+I/1dQhoRmVW/84Ky+V8WwO
         yUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697726065; x=1698330865;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wjZ4qxx8eHlX52M396pyZosQWfD8ZyKpN5ePJA4neiE=;
        b=CZZHYy6Puo1A1nWYIA1saGIHYzPGOaqWzy4DzYEHOlOpAIWZGC1SeKhuBstIIJuxnY
         uXJi+atymWr4OstrP/uj/HE/hwTDz2EjKFtSC1t3ahaQTKaTih896RvXdYRDeeWlnNl7
         xiHWGsdae0oJ7AWcZVEuyBiKwN+pgnslBXqNx8xnS/GZZ53KKHycSHRYc2KXn18s1A1v
         3l6q2py5kuSVUFysTg1uclxN1WjHAj7FKbJelxal7ydPFHpfkmfK5CkCPCxdxKXatkme
         21rbth9w/F2KhcoRsIY7vEcvherzlEM9ZqI3kWeZ+/i/V9oTfZyV9q7gtnHgLvPRCSs2
         1Ddg==
X-Gm-Message-State: AOJu0YygrvdhPeo7Vqo+5Wd0fievIVBS2yB/4Wb6T7Rv1XBRFPq9FOPw
	lvenNgf5Vt66GbcZL2g7Okg=
X-Google-Smtp-Source: AGHT+IH7oheBFbdkZ+jvbENM2Z4YvGDikAry9vlb6z1zm56NUuXSc/n9S8KqlcvxgoQmBMRFXK/KXg==
X-Received: by 2002:a05:6808:16a9:b0:3b2:ec6d:e17e with SMTP id bb41-20020a05680816a900b003b2ec6de17emr2703476oib.9.1697726065037;
        Thu, 19 Oct 2023 07:34:25 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id u12-20020a056808000c00b003af6c5783adsm1080730oic.5.2023.10.19.07.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 07:34:24 -0700 (PDT)
Message-ID: <f5a2fc30-c931-40d8-b012-b72a5130ebae@gmail.com>
Date: Thu, 19 Oct 2023 09:34:22 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/21] dpp-util: allow for mutual authentication in
 i/r_auth
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231012200150.338401-1-prestwoj@gmail.com>
 <20231012200150.338401-8-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231012200150.338401-8-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/12/23 15:01, James Prestwood wrote:
> When using mutual authentication an additional value needs to
> be hashed when deriving i/r_auth values. A NULL value indicates
> no mutual authentication (zero length iovec is passed to hash).
> ---
>   src/dpp-util.c | 20 ++++++++++++++++----
>   src/dpp-util.h |  4 +++-
>   src/dpp.c      |  8 ++++----
>   3 files changed, 23 insertions(+), 9 deletions(-)
> 

Patches 7-9 applied, thanks.

Regards,
-Denis

