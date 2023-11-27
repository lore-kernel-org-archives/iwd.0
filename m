Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C4720F5
	for <iwd@lists.linux.dev>; Mon, 27 Nov 2023 03:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6rybEAn"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3b837d974ecso2373408b6e.2
        for <iwd@lists.linux.dev>; Sun, 26 Nov 2023 19:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701055502; x=1701660302; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WuzswIaHHHeAFYeJPKuj0qiUaaP6wtiovEgPaVJX1yE=;
        b=c6rybEAnfMdHq4o5B8e5/9J6G9UQ0DqaIUXBtR8WFfrFlNG/rkWJwQMTYJrSyQ8RKz
         YIrjVpsAOk6XWPqTC9Kc/DfTTpyTs2SRp8vZ2EKgStiG77gXoIfu/TtkOVmFW17WWUi9
         aJPGZNpSdegkeFPaTIInXkqZRY4u7v3DK5LPChyJ2iV1azLI45Ctbg4X6vb0TDReJqwL
         oTjsPFkeASrdFEuLB1q5EVS1fd9uoqpacZ81AlFHTu5MnzxG4cdObiIxfEntwlorhVZV
         ELfMLrPIsN7Vm4+Pc/4RAFF8J3AtUeB16hNbVIzB8UCiqN2WOXReS1RtKF5TSzn0ueWl
         RWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701055502; x=1701660302;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WuzswIaHHHeAFYeJPKuj0qiUaaP6wtiovEgPaVJX1yE=;
        b=wz/bRHvMYNfUNPeEGf9tVGVfr0TSGn86SxNvrLbHlnPjvaezswnehWvHrd6lPDDSZd
         kxIaRpGMs/9zZRXYPBJe+MQlk76IIDXeC/rU1K++3LlRBw4+J3/woBgBrho0HglOOsbM
         9ozlrHwHaCRKkaklHNXLg0m48RofQJKmPC02t62OVZ6+e4TeBBvBmCzySnXfXThUvrph
         zfaZkzqPE7st5Bc4Vcw5uW9Q1FgqPXvfQdJMdEqhSot9/Vz4Hqi9MPBDAWb1TnJceLJK
         xHdXB+U0owUBcL2h2rYRZpJuMkUihHPjnqwcFA8c46v3ya2LSRBpNazOotAwca84nESn
         TIow==
X-Gm-Message-State: AOJu0YxfRd33Z+gBsrWiSfKLB7/PSgSEy7q18w1QM5tcA57yMQmrB5xR
	zaE/dIxtxDsBG0TeZB3A6BzeJj/rvok=
X-Google-Smtp-Source: AGHT+IHgA8FrH666Q3CkYCpxz5kB6hdcmdPJb0UcDRIq/LIm2368QNwBs2YnHdoi/lO1c93Jt/Yl/g==
X-Received: by 2002:a05:6871:806:b0:1f9:e965:191d with SMTP id q6-20020a056871080600b001f9e965191dmr12072434oap.56.1701055502149;
        Sun, 26 Nov 2023 19:25:02 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id hm9-20020a0568701b8900b001fa51768610sm298584oab.34.2023.11.26.19.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 19:25:01 -0800 (PST)
Message-ID: <268d40b9-63a8-4aad-9f02-e9765325ec72@gmail.com>
Date: Sun, 26 Nov 2023 21:25:00 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IWD 2.9 Does Not Compile against Linux-4.9.212 and/or GLibC-2.28
Content-Language: en-US
To: Grant Erickson <gerickson@nuovations.com>, iwd@lists.linux.dev
Cc: Marcel Holtmann <marcel@holtmann.org>
References: <29B7EAE3-2BBD-43CA-B2E7-28CE588EE7A2@nuovations.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <29B7EAE3-2BBD-43CA-B2E7-28CE588EE7A2@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Grant,

>        CC       client/known-networks.o
>      ${BuildRoot}/third_party/iwd/iwd-2.9/client/known-networks.c:27: warning: "_XOPEN_SOURCE" redefined
>         27 | #define _XOPEN_SOURCE

libreadline adds -D_XOPEN_SOURCE to the gcc command line.  Somehow newer GCC 
versions deal with this transparently and don't raise an error.  Maybe try

#ifndef _XOPEN_SOURCE
#define _XOPEN_SOURCE
#endif

in client/known-networks.c and report back?  I can't duplicate this on my end.

>            |
>      <command-line>: note: this is the location of the previous definition
>      ${BuildRoot}/third_party/iwd/iwd-2.9/client/display.c: In function ‘display_init’:
>      ${BuildRoot}/third_party/iwd/iwd-2.9/client/display.c:949:44: warning: assignment to ‘void (*)(void)’ from incompatible pointer type ‘void (*)(char **, int,  int)’ [-Wincompatible-pointer-types]
>        949 |         rl_completion_display_matches_hook = display_completion_matches;
>            |                                            ^

This one is trickier since the signature of the function we provide is correct 
according to libreadline documentation.  What version of readline are you using?

>        CC       src/adhoc.o
>        CC       src/sae.o
>      In file included from ${BuildRoot}/third_party/iwd/iwd-2.9/src/adhoc.c:28:
>      ${BuildRoot}/results/${PRODUCT}/arm/gnu-toolchain/12.3.1/release/third_party/linux/linux-dey/include/linux/if.h:234:34: error: field ‘ifru_addr’ has incomplete type
>        234 |                 struct  sockaddr ifru_addr;
>            |                                  ^~~~~~~~~
>      ${BuildRoot}/results/${PRODUCT}/arm/gnu-toolchain/12.3.1/release/third_party/linux/linux-dey/include/linux/if.h:235:34: error: field ‘ifru_dstaddr’ has incomplete type
>        235 |                 struct  sockaddr ifru_dstaddr;
>            |                                  ^~~~~~~~~~~~
>      ${BuildRoot}/results/${PRODUCT}/arm/gnu-toolchain/12.3.1/release/third_party/linux/linux-dey/include/linux/if.h:236:34: error: field ‘ifru_broadaddr’ has incomplete type
>        236 |                 struct  sockaddr ifru_broadaddr;
>            |                                  ^~~~~~~~~~~~~~
>      ${BuildRoot}/results/${PRODUCT}/arm/gnu-toolchain/12.3.1/release/third_party/linux/linux-dey/include/linux/if.h:237:34: error: field ‘ifru_netmask’ has incomplete type
>        237 |                 struct  sockaddr ifru_netmask;
>            |                                  ^~~~~~~~~~~~
>      ${BuildRoot}/results/${PRODUCT}/arm/gnu-toolchain/12.3.1/release/third_party/linux/linux-dey/include/linux/if.h:238:34: error: field ‘ifru_hwaddr’ has incomplete type
>        238 |                 struct  sockaddr ifru_hwaddr;
>            |                                  ^~~~~~~~~~~
>      make[2]: *** [Makefile:2539: src/adhoc.o] Error 1
>      make[2]: *** Waiting for unfinished jobs....
>      make[1]: *** [Makefile:1713: all] Error 2
>      make[1]: Leaving directory '${BuildRoot}/third_party/iwd/.build/Makefile/${PRODUCT}/arm/gnu-toolchain/12.3.1/release'
>      make: *** [Makefile:110: build] Error 2

This should be fixed by the patch I just sent out.

Regards,
-Denis
