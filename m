Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC84C250E5;
	Fri, 15 Mar 2024 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710508178; cv=none; b=L+XC6/4lqr9GcwnczEYs2k4f2pjrypy3Yc9g9feLvclN+Vu9v/Q/ZCK4G8qoo7WwXeZPyqnKV37OxC3X0V0Bf72dc2jC+xw+LQZnZ8gip6NTuzfHfGFeCYWYJv0Qgt1LJhC1sFbTBF75gr1qmBFrrC0bSsBCsA/12u2gQmzqqJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710508178; c=relaxed/simple;
	bh=W+ABfQLN3KCOvRqGEyd8pg1ypVwpXtU704uye5orKeI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:From:
	 References:In-Reply-To; b=hOC77L13jhYUIlX+5DL3jc45i6iPgln2ZcvhNYER7zQKmtFreBjd+UdIUPBjym3riCyvKwERrwTrYfmh1EkseVCkSJSfksLJuzlqMuYGX7eFnSt2wrwrXwyDMqEb/SxDHvI1BysflDilmL2Ynoj+HLge56TkEpp550ZSFkRYu3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
Received: from localhost (cdwifi-a106.cd-t.cz [213.235.133.106] (may be forged))
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 42FD8Ug8098517
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 15 Mar 2024 14:08:33 +0100 (CET)
	(envelope-from balejk@matfyz.cz)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 15 Mar 2024 14:09:01 +0100
Message-Id: <CZUCJ4CEVXMS.2MML8IFVVTBC9@matfyz.cz>
Cc: <alexandre.torgue@foss.st.com>, <davem@davemloft.net>,
        <dhowells@redhat.com>, <herbert@gondor.apana.org.au>,
        <keyrings@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-modules@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <mcgrof@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <dimitri.ledkov@canonical.com>,
        <iwd@lists.linux.dev>, "Johannes Berg" <johannes@sipsolutions.net>,
        "James
 Prestwood" <prestwoj@gmail.com>,
        "Michael Yartys" <mail@yartys.no>
Subject: Re: [REGRESSION] Re: [PATCH] crypto: pkcs7: remove sha1 support
To: <regressions@lists.linux.dev>
From: "Karel Balej" <balejk@matfyz.cz>
References: <005f998ec59e27633b1b99fdf929e40ccfd401c1.camel@sipsolutions.net> <f2dcbe55-0f0e-4173-8e21-f899c6fc802a@gmail.com> <NbWQKmrYDD20KKHeq9TMda2MJFE00-weepZGuSIRzO5BOgMlTbWBkDlNNweA2dhbvF8TK1F_cHbMxblLVNREZa1HZEFt9TVCkTB1jo_5ppc=@yartys.no> <CZSHRUIJ4RKL.34T4EASV5DNJM@matfyz.cz> <20231010212240.61637-1-dimitri.ledkov@canonical.com> <CZSVWO3IDZ96.38O0P161Z99XU@matfyz.cz>
In-Reply-To: <CZSVWO3IDZ96.38O0P161Z99XU@matfyz.cz>

#regzbot title: SHA1 support removal breaks iwd's ability to connect to edu=
roam
#regzbot monitor: https://lore.kernel.org/all/20240313233227.56391-1-ebigge=
rs@kernel.org/
#regzbot monitor: https://lore.kernel.org/all/CZSHRUIJ4RKL.34T4EASV5DNJM@ma=
tfyz.cz/
#regzbot link: https://lore.kernel.org/iwd/njvxKaPo_CBxsQGaNSRHj8xOSxzk1_j_=
K-minIe4GCKUMB1qxJT8nPk9SGmfqg7Aepm_5dO7FEofYIYP1g15R9V5dJ0F8bN6O4VthSjzu1g=
=3D@yartys.no/

Sorry for the tracking mess...
