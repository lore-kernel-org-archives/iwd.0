Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44715393
	for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 19:36:39 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id y10-20020a9d634a000000b006167f7ce0c5so12549102otk.0
        for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 12:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=D0yidU2KFMTAc9U5ucxZHu+Nle89kk3DibT/XDYkN2o=;
        b=X8TIWCefB+INev84MH2Gr6Ai6z1D6vAc/iV37Ub95wglODKSffxx87sjezPPwVCWNn
         PoITgeEID2zQ9MxKsbupeZizxp69dPzPvGEd2HRdNt06ZGi9qg0Yqyxc/mJ+7Mxf9+qj
         NkBC0Qv58QYw0NhctFLYynGqmUs3RUlWAfyhDI2d31+HpbzqR0gMpVio/Tz4ySQrRWp3
         sOwJ7TSnOaI72syJGgfEd9bCyfrsIWF/tW9298PQL9fiN2QWwjxoCrtRBBE/cyJlfzZA
         /wXsAPDd/OqONI9FnFO5Oc8PG1l0xiKlkTwr/KEpmAy2RhNrvlTm0/OMIFfC+EmWSuMz
         Rfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=D0yidU2KFMTAc9U5ucxZHu+Nle89kk3DibT/XDYkN2o=;
        b=R+ZUXr0Z0bHFRcbmM/uVYdyvp2yMraeclabinQ77tVr8VCBR9qCM0W0ok08ZKi7V77
         Lwfqr+ae3JOFPcKnAQF0ui+CKDLoLOjw2yKM4zsK8eiEFzcNwIe6mXf9Rbeo2WCKyOI6
         CJvZYr9JCS7Qgydy8uM2ffpoPZ4kapHQIJ1LUdePGt0lvuws1DQPOkVN8JKic/ohkYQ5
         uJE6gOwMZPNnjYWyKgPkatESnjZSoa0kMfWMWAp9Ufx8gMgsnAGOYj55W0K/JpT3TuXE
         GVO3SItHnLxcRS2qbw2IJLo5Z0K2opNg6eCueu0L3bEN5hEl9DZTu3YyLWwjVvdsdLIk
         FIuA==
X-Gm-Message-State: AJIora+Ym4XTKn7sPSDhXuu6CPUCyJsSfwXr9Uz1D78t3ufYK7g3BfSz
	K7Jc9vMSsFbb7hYL29EkSXY=
X-Google-Smtp-Source: AGRyM1uB9JB0p+Ei3dApyACpXWGS70vA6CBfM1nGM3gZtcEyovb6VIO+pHQIh8reS0UOhkSGM8PWqA==
X-Received: by 2002:a9d:6c47:0:b0:61c:afde:5929 with SMTP id g7-20020a9d6c47000000b0061cafde5929mr3065863otq.4.1658259398561;
        Tue, 19 Jul 2022 12:36:38 -0700 (PDT)
Received: from [10.0.2.15] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id x73-20020a4a414c000000b0043540f7701esm6346381ooa.31.2022.07.19.12.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 12:36:38 -0700 (PDT)
Message-ID: <94cf57f4-e15e-ad07-3d96-e3aa8d7e94af@gmail.com>
Date: Tue, 19 Jul 2022 14:33:54 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/3] test-runner: allow infinite process wait
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220719185223.456197-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220719185223.456197-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 7/19/22 13:52, James Prestwood wrote:
> subprocess.Popen's wait() method was overwritten to be non-blocking but
> in certain circumstances you do want to wait forever. Fix this to allow
> timeout=None, which calls the parent wait() method directly.
> ---
>   tools/utils.py | 4 ++++
>   1 file changed, 4 insertions(+)
> 

All applied, thanks.

Regards,
-Denis

