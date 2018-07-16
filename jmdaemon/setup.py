from setuptools import setup


setup(name='joinmarketdaemon',
      version='0.3.1',
      description='Joinmarket client library for Bitcoin coinjoins',
      url='http://github.com/AdamISZ/joinmarket-clientserver/jmdaemon',
      author='Adam Gibson',
      author_email='ekaggata@gmail.com',
      license='GPL',
      packages=['jmdaemon'],
      install_requires=['txsocksx', 'pyopenssl', 'libnacl', 'joinmarketbase==0.3.1'],
      zip_safe=False)
